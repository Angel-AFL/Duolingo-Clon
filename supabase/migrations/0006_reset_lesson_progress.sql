-- Repara cuentas cuyo camino de aprendizaje quedo sin nodo activo (p. ej.
-- todas las lecciones en 'completed' por el comportamiento antiguo del home).
-- Idempotente: tras reiniciar, position 0 queda 'active' y ya no coincide.
-- Aplicar en el SQL Editor del dashboard de Supabase.

update public.lesson_nodes ln
set status = case when ln.position = 0 then 'active' else 'locked' end
where not exists (
  select 1
  from public.lesson_nodes a
  where a.user_id = ln.user_id and a.status = 'active'
);
