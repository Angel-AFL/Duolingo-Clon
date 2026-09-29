-- Normaliza el camino de aprendizaje de cuentas con las posiciones invertidas.
-- Idempotente: solo actua sobre usuarios cuyo nodo en position 0 es 'dialogue'
-- (firma de un camino al reves). El trigger ya inserta en orden canonico.
-- Aplicar en el SQL Editor del dashboard de Supabase.

-- 1) Desplazar las posiciones de los usuarios invertidos para evitar el
--    conflicto con la restriccion unique (user_id, position) durante el swap.
update public.lesson_nodes
set position = position + 100
where user_id in (
  select user_id
  from public.lesson_nodes
  where position = 0 and type = 'dialogue'
);

-- 2) Remapear al orden canonico (star activo en 0 ... dialogue en 6).
update public.lesson_nodes
set position = case position
  when 100 then 6
  when 101 then 5
  when 102 then 4
  when 103 then 3
  when 104 then 2
  when 105 then 1
  when 106 then 0
  else position
end
where position >= 100;
