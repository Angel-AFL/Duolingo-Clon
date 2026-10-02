-- Suma de EXP atomica para perfil y liga.
-- Evita el read-modify-write del cliente (que puede perder datos con
-- escrituras concurrentes). Aplicar en el SQL Editor del dashboard.

-- ---------------------------------------------------------------------------
-- Perfil: total_exp
-- ---------------------------------------------------------------------------
create or replace function public.increment_profile_exp(amount int)
returns int
language sql
security invoker
set search_path = public
as $$
  update public.profiles
     set total_exp = total_exp + amount
   where id = auth.uid()
  returning total_exp;
$$;

-- ---------------------------------------------------------------------------
-- Liga: EXP del usuario actual en su tabla
-- ---------------------------------------------------------------------------
create or replace function public.increment_league_exp(amount int)
returns int
language sql
security invoker
set search_path = public
as $$
  update public.league_members
     set exp = exp + amount
   where user_id = auth.uid()
  returning exp;
$$;

grant execute on function public.increment_profile_exp(int) to authenticated;
grant execute on function public.increment_league_exp(int) to authenticated;
