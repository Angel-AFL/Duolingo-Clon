# AGENTS.md

Flutter app (Dart `^3.12.0`, Flutter 3.44) that clones the Duolingo mobile UI.
`docs/` holds 5 hand-drawn sketches (home, liga, desafios, perfil, rachas)
and is the **source of truth for UI**. Login + the 4 main tabs are implemented
through `AppShell`. Data comes from **Supabase** through repositories
(`lib/data/repositories/`); `lib/data/mock_data.dart` is kept only as the
offline fallback used by the `Mock*` repositories and as the initial provider
state. Models in `lib/models/` carry `fromJson`/`toJson` for the DB rows.

## Commands
- Install deps: `flutter pub get`
- Analyze (run before finishing): `flutter analyze`
- All tests: `flutter test`
- Single test: `flutter test test/widget_test.dart`
- Run app: `flutter run -d chrome` (or `-d windows`). Supabase credentials live
  in `.env` (gitignored; copy `.env.example` and fill `SUPABASE_URL` /
  `SUPABASE_ANON_KEY`). If unset, the app falls back to mock data and the login
  still works via `MockAuthRepository`.
- Apply DB schema: paste `supabase/migrations/0001_initial_schema.sql` into the
  Supabase dashboard SQL editor (no local CLI required).
- Format: `dart format lib test` (Dart 3.12 formatter rewrites the whole tree;
  expect unrelated formatting-only diffs)

## Design system (load the `duolingo` skill first)
- The `duolingo` skill only defines the **light marketing** theme. The app
  screens in `docs/` are **dark**, so `lib/core/theme/app_colors.dart` adds a
  documented `dark*` extension. Login stays light, app screens dark.
- Never hardcode colors/spacing/text styles. Use `AppColors`, `AppTypography`,
  `AppSpacing`/`AppRadius` (`lib/core/theme/`). Radii are always 12px.
- Skill fonts `feather` / `duolingo-sans` are substituted with **Nunito** via
  `google_fonts`. In widget tests set
  `GoogleFonts.config.allowRuntimeFetching = false` (see `test/widget_test.dart`).

## Architecture
- Entry flow: `lib/main.dart` (loads `.env`, `Supabase.initialize`, MultiProvider)
  -> `lib/app.dart` (`AuthGate` picks `LoginScreen` or `AppShell`) ->
  `lib/screens/shell/app_shell.dart` (bottom-nav tabs via `IndexedStack`) ->
  `lib/screens/<feature>/`. `StreakScreen` is pushed without the bottom nav.
- State: `provider` with `ChangeNotifier` in `lib/providers/`. Each provider
  takes an optional repository and starts from `MockData`, then `load()` swaps in
  Supabase data. Repositories live in `lib/data/repositories/` (interface +
  `Supabase*` impl + `Mock*` impl). `main.dart` injects the Supabase impls when
  `.env` is configured, otherwise the providers fall back to their `Mock*` defaults.
  `main.dart` **does not** call `load()`: the `Supabase*` repos read
  `auth.currentUser`, so loading only happens once there is a session. `AppShell`
  (which only builds authenticated) calls `load()` on all providers from
  `initState` via a post-frame callback; sign-out/sign-in rebuilds it and reloads.
- Profile: `SupabaseProfileRepository.fetchProfile()` uses `maybeSingle()` and
  falls back to an upsert of a default row when the user has no `profiles` row
  (e.g. accounts created before the schema). `ProfileProvider` exposes
  `isLoading`/`hasLoaded`/`hasError`; `ProfileScreen` shows a loader on first
  load, an error + retry view, and wraps its list in a `RefreshIndicator`.
- Profile photo: the header perchero (`checkroom_rounded`) opens
  `showAvatarPickerSheet` (presets + `image_picker` gallery/camera). Photos go to
  the public `avatars` Storage bucket at `{userId}/avatar_<ts>.<ext>` and the URL
  is saved in `profiles.avatar_url`; presets are saved as `preset:<id>` and
  rendered from `lib/models/avatar_preset.dart`. `avatar_url` may hold an
  `https://` URL, an `assets/...` path, or a `preset:<id>` key. Apply
  `supabase/migrations/0002_profile_avatar.sql` for the column, bucket and RLS.
- Auth: `AuthProvider` wraps `AuthRepository`; `AuthGate` in `app.dart` reacts to
  `isAuthenticated`. `LoginScreen` handles email/password sign-in and sign-up.
- Routes are string constants in `lib/routes/app_routes.dart`. Only `streak` and
  `lesson` are named routes; login/shell are chosen by `AuthGate`. `lesson`
  receives the node position via `ModalRoute.settings.arguments`.
- Lecciones: al tocar un nodo `active` o `completed` del home se abre
  `LessonScreen` (sin bottom nav), que carga los ejercicios de `lesson_exercises`
  (o `MockData.lessonExercises`) via `LessonProvider`. La barra superior usa
  `LessonProgressBar`, que avanza al pulsar continuar (no al comprobar) y colorea
  cada ejercicio (verde acierto, rojo error, gris pendiente). Al terminar siempre
  suma EXP con `ChallengesProvider.recordLesson(LessonOutcome)` (que avanza cada
  reto segun su metrica `exp`/`streak`/`accuracy`), y tambien con
  `ProfileProvider.addExp()` y `LeagueProvider.addExp()`; solo llama a
  `LearningPathProvider.completeCurrent()` si la leccion jugada era el nodo activo
  (repetir una completada no avanza el camino). Aplicar
  `supabase/migrations/0004_lesson_exercises.sql` para la tabla y el seed,
  `0005_normalize_lesson_nodes.sql` si alguna cuenta tiene el camino invertido, y
  `0006_reset_lesson_progress.sql` si quedo sin nodo activo (todo `completed`).
  `0007_challenge_metrics.sql` agrega `daily_challenges.metric` y ajusta el seed.
- `AppShell` maps bottom-nav indices to screens: 0 Home, 1 Desafios, 4 Liga,
  5 Perfil. Indices 2/3 have no sketch and are no-ops. Add new tabs there.
- Adding a provider means registering it in `lib/main.dart` **and** the test
  helper in `test/widget_test.dart`.
- Static, non-user strings (section banner, challenge partner) live in
  `lib/data/app_constants.dart`, not in the DB. El mes y los días restantes del
  desafío se calculan con la fecha actual (`lib/core/utils/formatters.dart`).
- Shared widgets in `lib/widgets/`; screen-specific sub-widgets in
  `lib/screens/<feature>/widgets/`.
- `app.dart` sets `themeMode: ThemeMode.dark`; `LoginScreen` overrides with an
  explicit white surface.

## Testing quirks
- Tests must supply all 8 providers; `AppShell` uses `IndexedStack`, so every
  tab builds even when not selected (missing provider throws regardless). Tests
  use the default `Mock*` repositories, so no Supabase init/network is needed.
- `test/widget_test.dart` logs in by filling the two `TextField`s and tapping
  `INICIAR SESIÓN`; `MockAuthRepository` accepts any credentials.
- `SectionLabel` renders `.toUpperCase()` — match finders to the uppercase text.
- Tall screens (profile) push content off the 800x600 test surface; set
  `tester.view.physicalSize` (see the profile test) or scroll.

## Gotchas
- The Duo mascot is a `CustomPaint` placeholder. To use a real image, set
  `AppAssets.hasMascotAsset = true` and register `assets/images/duo.png` in
  `pubspec.yaml`.
- `README.md` contains null bytes, so the Read tool reports it as binary — use
  `Get-Content` if you need its contents.
- The Flutter template used Dart 3.12 dot-shorthands (`.fromSeed`, `.center`);
  either style is valid.
