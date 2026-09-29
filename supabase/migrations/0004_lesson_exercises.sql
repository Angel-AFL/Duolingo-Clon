-- Ejercicios de las lecciones del camino de aprendizaje.
-- Contenido no ligado al usuario: se comparte entre cuentas.
-- Aplicar en el SQL Editor del dashboard de Supabase.

create table if not exists public.lesson_exercises (
  id bigint generated always as identity primary key,
  lesson_position int not null,
  position int not null,
  type text not null,
  prompt text not null,
  options jsonb not null default '[]'::jsonb,
  answer jsonb not null default '[]'::jsonb,
  pairs jsonb not null default '[]'::jsonb,
  unique (lesson_position, position)
);

alter table public.lesson_exercises enable row level security;

drop policy if exists "read lesson exercises" on public.lesson_exercises;
create policy "read lesson exercises" on public.lesson_exercises
  for select to authenticated using (true);

-- ---------------------------------------------------------------------------
-- Contenido de demo (curso espanol -> ingles)
-- ---------------------------------------------------------------------------
insert into public.lesson_exercises
  (lesson_position, position, type, prompt, options, answer, pairs)
values
  -- Leccion 0: comida
  (0, 0, 'multiple_choice', '¿Cuál de estas es «la manzana»?',
    '["the apple","the bread","the water","the milk"]'::jsonb,
    '["the apple"]'::jsonb, '[]'::jsonb),
  (0, 1, 'word_bank', 'Traduce: El niño come pan',
    '["The","boy","eats","bread","water","runs"]'::jsonb,
    '["The","boy","eats","bread"]'::jsonb, '[]'::jsonb),
  (0, 2, 'match_pairs', 'Empareja las palabras', '[]'::jsonb, '[]'::jsonb,
    '[{"left":"agua","right":"water"},{"left":"leche","right":"milk"},{"left":"pan","right":"bread"}]'::jsonb),
  (0, 3, 'fill_blank', 'Ella ___ una manzana',
    '["eat","eats","eating","ate"]'::jsonb, '["eats"]'::jsonb, '[]'::jsonb),

  -- Leccion 1: animales
  (1, 0, 'multiple_choice', '¿Cuál de estas es «el gato»?',
    '["the cat","the dog","the bird","the fish"]'::jsonb,
    '["the cat"]'::jsonb, '[]'::jsonb),
  (1, 1, 'word_bank', 'Traduce: La niña tiene un perro',
    '["The","girl","has","a","dog","cat","runs"]'::jsonb,
    '["The","girl","has","a","dog"]'::jsonb, '[]'::jsonb),
  (1, 2, 'match_pairs', 'Empareja las palabras', '[]'::jsonb, '[]'::jsonb,
    '[{"left":"caballo","right":"horse"},{"left":"pájaro","right":"bird"},{"left":"pez","right":"fish"}]'::jsonb),
  (1, 3, 'fill_blank', 'El perro ___ en el parque',
    '["run","runs","running","ran"]'::jsonb, '["runs"]'::jsonb, '[]'::jsonb),

  -- Leccion 2: familia
  (2, 0, 'multiple_choice', '¿Cuál de estas es «la madre»?',
    '["the mother","the father","the sister","the brother"]'::jsonb,
    '["the mother"]'::jsonb, '[]'::jsonb),
  (2, 1, 'word_bank', 'Traduce: Mi hermana es médica',
    '["My","sister","is","a","doctor","brother","teacher"]'::jsonb,
    '["My","sister","is","a","doctor"]'::jsonb, '[]'::jsonb),
  (2, 2, 'match_pairs', 'Empareja las palabras', '[]'::jsonb, '[]'::jsonb,
    '[{"left":"padre","right":"father"},{"left":"hermano","right":"brother"},{"left":"abuela","right":"grandmother"}]'::jsonb),
  (2, 3, 'fill_blank', 'Mi ___ trabaja en casa',
    '["father","mother","parents","brothers"]'::jsonb,
    '["father"]'::jsonb, '[]'::jsonb),

  -- Leccion 3: colores
  (3, 0, 'multiple_choice', '¿Cuál de estas es «rojo»?',
    '["red","blue","green","yellow"]'::jsonb,
    '["red"]'::jsonb, '[]'::jsonb),
  (3, 1, 'word_bank', 'Traduce: La flor es amarilla',
    '["The","flower","is","yellow","red","green"]'::jsonb,
    '["The","flower","is","yellow"]'::jsonb, '[]'::jsonb),
  (3, 2, 'match_pairs', 'Empareja los colores', '[]'::jsonb, '[]'::jsonb,
    '[{"left":"azul","right":"blue"},{"left":"verde","right":"green"},{"left":"negro","right":"black"}]'::jsonb),
  (3, 3, 'fill_blank', 'El cielo es ___',
    '["blue","red","green","black"]'::jsonb, '["blue"]'::jsonb, '[]'::jsonb),

  -- Leccion 4: numeros
  (4, 0, 'multiple_choice', '¿Cuál de estas es «tres»?',
    '["three","two","four","five"]'::jsonb,
    '["three"]'::jsonb, '[]'::jsonb),
  (4, 1, 'word_bank', 'Traduce: Tengo dos hermanos',
    '["I","have","two","brothers","three","sisters"]'::jsonb,
    '["I","have","two","brothers"]'::jsonb, '[]'::jsonb),
  (4, 2, 'match_pairs', 'Empareja los números', '[]'::jsonb, '[]'::jsonb,
    '[{"left":"uno","right":"one"},{"left":"cinco","right":"five"},{"left":"diez","right":"ten"}]'::jsonb),
  (4, 3, 'fill_blank', 'Hay ___ manzanas',
    '["four","for","fore","fourth"]'::jsonb, '["four"]'::jsonb, '[]'::jsonb),

  -- Leccion 5: acciones
  (5, 0, 'multiple_choice', '¿Cuál de estas es «correr»?',
    '["to run","to eat","to sleep","to read"]'::jsonb,
    '["to run"]'::jsonb, '[]'::jsonb),
  (5, 1, 'word_bank', 'Traduce: Ella lee un libro',
    '["She","reads","a","book","runs","writes"]'::jsonb,
    '["She","reads","a","book"]'::jsonb, '[]'::jsonb),
  (5, 2, 'match_pairs', 'Empareja los verbos', '[]'::jsonb, '[]'::jsonb,
    '[{"left":"comer","right":"to eat"},{"left":"beber","right":"to drink"},{"left":"dormir","right":"to sleep"}]'::jsonb),
  (5, 3, 'fill_blank', 'Nosotros ___ español',
    '["speak","speaks","speaking","spoke"]'::jsonb, '["speak"]'::jsonb, '[]'::jsonb),

  -- Leccion 6: sentimientos
  (6, 0, 'multiple_choice', '¿Cuál de estas es «feliz»?',
    '["happy","sad","tired","angry"]'::jsonb,
    '["happy"]'::jsonb, '[]'::jsonb),
  (6, 1, 'word_bank', 'Traduce: Estoy muy contento',
    '["I","am","very","happy","sad","tired"]'::jsonb,
    '["I","am","very","happy"]'::jsonb, '[]'::jsonb),
  (6, 2, 'match_pairs', 'Empareja los sentimientos', '[]'::jsonb, '[]'::jsonb,
    '[{"left":"triste","right":"sad"},{"left":"cansado","right":"tired"},{"left":"enojado","right":"angry"}]'::jsonb),
  (6, 3, 'fill_blank', 'Ella está ___ hoy',
    '["happy","happiness","happily","happen"]'::jsonb, '["happy"]'::jsonb, '[]'::jsonb)
on conflict (lesson_position, position) do nothing;
