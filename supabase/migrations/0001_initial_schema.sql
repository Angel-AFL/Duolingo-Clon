-- Esquema inicial del clon de Duolingo.
-- Aplicar en el SQL Editor del dashboard de Supabase.

-- ---------------------------------------------------------------------------
-- Perfil
-- ---------------------------------------------------------------------------
create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  name text not null default '',
  handle text not null default '',
  joined_year int not null default extract(year from now())::int,
  super_since int not null default extract(year from now())::int,
  courses int not null default 0,
  following int not null default 0,
  followers int not null default 0,
  league text not null default 'Diamante',
  total_exp int not null default 0
);

-- ---------------------------------------------------------------------------
-- Stats de la barra superior
-- ---------------------------------------------------------------------------
create table if not exists public.user_stats (
  user_id uuid primary key references auth.users (id) on delete cascade,
  course_flag text not null default '🇺🇸',
  course_count int not null default 0,
  streak_days int not null default 0,
  gems int not null default 0,
  has_unlimited_hearts boolean not null default false
);

-- ---------------------------------------------------------------------------
-- Camino de aprendizaje
-- ---------------------------------------------------------------------------
create table if not exists public.lesson_nodes (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users (id) on delete cascade,
  position int not null,
  type text not null,
  status text not null,
  horizontal_offset double precision not null default 0,
  unique (user_id, position)
);

-- ---------------------------------------------------------------------------
-- Liga
-- ---------------------------------------------------------------------------
create table if not exists public.leagues (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  name text not null default 'Final',
  days_left int not null default 4
);

create table if not exists public.league_members (
  id bigint generated always as identity primary key,
  league_id uuid not null references public.leagues (id) on delete cascade,
  user_id uuid references auth.users (id) on delete set null,
  rank int not null,
  name text not null,
  flag text not null default '🇺🇸',
  course_count int not null default 0,
  exp int not null default 0,
  avatar_color bigint not null default 0xffe8a87c,
  is_current_user boolean not null default false
);

-- ---------------------------------------------------------------------------
-- Desafios
-- ---------------------------------------------------------------------------
create table if not exists public.challenge_state (
  user_id uuid primary key references auth.users (id) on delete cascade,
  points int not null default 0,
  points_target int not null default 60
);

create table if not exists public.daily_challenges (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users (id) on delete cascade,
  position int not null,
  title text not null,
  progress int not null default 0,
  target int not null,
  reward text not null,
  unique (user_id, position)
);

-- ---------------------------------------------------------------------------
-- Rachas entre amigos
-- ---------------------------------------------------------------------------
create table if not exists public.friend_streaks (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users (id) on delete cascade,
  position int not null,
  name text not null,
  days int not null default 0,
  avatar_color bigint not null default 0xffffb4a2,
  unique (user_id, position)
);

-- ---------------------------------------------------------------------------
-- Calendario de racha
-- ---------------------------------------------------------------------------
create table if not exists public.streak_calendar (
  user_id uuid primary key references auth.users (id) on delete cascade,
  month_name text not null default 'septiembre',
  year int not null default extract(year from now())::int,
  practice_days int not null default 0,
  freezes_used int not null default 0,
  perfect_weeks int not null default 0,
  active_days int[] not null default '{}',
  today int not null default 1
);

-- ---------------------------------------------------------------------------
-- Row Level Security: cada usuario solo ve/edita sus filas
-- ---------------------------------------------------------------------------
alter table public.profiles enable row level security;
alter table public.user_stats enable row level security;
alter table public.lesson_nodes enable row level security;
alter table public.leagues enable row level security;
alter table public.league_members enable row level security;
alter table public.daily_challenges enable row level security;
alter table public.friend_streaks enable row level security;
alter table public.streak_calendar enable row level security;
alter table public.challenge_state enable row level security;

create policy "own profile" on public.profiles
  for all using (auth.uid() = id) with check (auth.uid() = id);

create policy "own stats" on public.user_stats
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own lesson nodes" on public.lesson_nodes
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own leagues" on public.leagues
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own league members" on public.league_members
  for all
  using (
    exists (
      select 1 from public.leagues l
      where l.id = league_id and l.user_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1 from public.leagues l
      where l.id = league_id and l.user_id = auth.uid()
    )
  );

create policy "own challenges" on public.daily_challenges
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own friend streaks" on public.friend_streaks
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own streak calendar" on public.streak_calendar
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own challenge state" on public.challenge_state
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- ---------------------------------------------------------------------------
-- Alta de usuario: crea perfil, stats y datos iniciales de demo
-- ---------------------------------------------------------------------------
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  new_league_id uuid;
begin
  insert into public.profiles (id, name, handle)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'name', split_part(new.email, '@', 1)),
    '@' || upper(split_part(new.email, '@', 1))
  );

  insert into public.user_stats (user_id) values (new.id);

  insert into public.lesson_nodes (user_id, position, type, status, horizontal_offset)
  values
    (new.id, 0, 'star', 'active', 0),
    (new.id, 1, 'book', 'locked', 0.45),
    (new.id, 2, 'star', 'locked', 0.12),
    (new.id, 3, 'chest', 'locked', -0.4),
    (new.id, 4, 'headphones', 'locked', 0.22),
    (new.id, 5, 'dumbbell', 'locked', -0.18),
    (new.id, 6, 'dialogue', 'locked', 0.28);

  insert into public.daily_challenges (user_id, position, title, target, reward)
  values
    (new.id, 0, 'Gana 50 EXP', 50, 'wood'),
    (new.id, 1, 'Responde correctamente 5 veces seguidas en 2 lecciones', 2, 'silver'),
    (new.id, 2, 'Obtén un puntaje de 90 % en 3 lecciones', 3, 'gold');

  insert into public.challenge_state (user_id, points, points_target)
  values (new.id, 27, 60);

  insert into public.friend_streaks (user_id, position, name, days, avatar_color)
  values
    (new.id, 0, 'Alex', 289, 4294948002),
    (new.id, 1, 'Bruno', 276, 4286302544),
    (new.id, 2, 'Carla', 201, 4292392162),
    (new.id, 3, 'Diana', 107, 4285448676),
    (new.id, 4, 'Hugo', 14, 4293418333);

  insert into public.streak_calendar (user_id, month_name, year, active_days, today)
  values (new.id, 'septiembre', extract(year from now())::int, '{1,2,3,4,5,6,7,8}', 9);

  insert into public.leagues (user_id, name, days_left)
  values (new.id, 'Final', 4)
  returning id into new_league_id;

  insert into public.league_members
    (league_id, user_id, rank, name, flag, course_count, exp, avatar_color, is_current_user)
  values
    (new_league_id, new.id, 1,
      coalesce(new.raw_user_meta_data ->> 'name', split_part(new.email, '@', 1)),
      '🇺🇸', 69, 928, 4293437564, true),
    (new_league_id, null, 2, 'Munchkin', '🇫🇷', 11, 668, 4289077981, false),
    (new_league_id, null, 3, 'Money Witt', '🇮🇹', 13, 466, 4288696877, false),
    (new_league_id, null, 4, 'Julian Carrasco', '🇨🇳', 10, 359, 4291200578, false),
    (new_league_id, null, 5, 'Cinthya Fernandez', '🇺🇸', 36, 317, 4294100891, false),
    (new_league_id, null, 6, 'Tom', '🇪🇸', 6, 260, 4291724031, false);

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
