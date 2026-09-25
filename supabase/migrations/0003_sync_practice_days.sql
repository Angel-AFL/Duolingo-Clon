-- Sincroniza streak_calendar.practice_days con user_stats.streak_days.
-- Aplicar en el SQL Editor del dashboard de Supabase despues de 0002.

-- ---------------------------------------------------------------------------
-- Alinear filas existentes: practice_days = streak_days
-- ---------------------------------------------------------------------------
update public.streak_calendar sc
set practice_days = us.streak_days
from public.user_stats us
where us.user_id = sc.user_id;

-- ---------------------------------------------------------------------------
-- Mantener sincronizado en cada alta/cambio de streak_days
-- ---------------------------------------------------------------------------
create or replace function public.sync_practice_days()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.streak_calendar
  set practice_days = new.streak_days
  where user_id = new.user_id;
  return new;
end;
$$;

drop trigger if exists sync_practice_days on public.user_stats;
create trigger sync_practice_days
  after insert or update of streak_days on public.user_stats
  for each row execute function public.sync_practice_days();
