-- Metricas de los retos diarios: cada reto avanza segun el resultado real de la
-- leccion (EXP ganado, racha de aciertos o precision).
-- Aplicar en el SQL Editor del dashboard de Supabase.

alter table public.daily_challenges
  add column if not exists metric text not null default 'exp';

-- Filas existentes: posicion 1 = racha, posicion 2 = precision.
update public.daily_challenges set metric = 'streak' where position = 1;
update public.daily_challenges set metric = 'accuracy' where position = 2;

-- El reto de racha se ajusta a algo alcanzable (cada leccion tiene 4 ejercicios).
update public.daily_challenges
  set title = 'Consigue una racha de 3 aciertos seguidos en 2 lecciones'
  where position = 1;

-- ---------------------------------------------------------------------------
-- Semilla para cuentas nuevas, incluyendo la metrica de cada reto.
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

  insert into public.daily_challenges (user_id, position, title, target, reward, metric)
  values
    (new.id, 0, 'Gana 50 EXP', 50, 'wood', 'exp'),
    (new.id, 1, 'Consigue una racha de 3 aciertos seguidos en 2 lecciones', 2, 'silver', 'streak'),
    (new.id, 2, 'Obtén un puntaje de 90 % en 3 lecciones', 3, 'gold', 'accuracy');

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
