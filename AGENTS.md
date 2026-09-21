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
- Auth: `AuthProvider` wraps `AuthRepository`; `AuthGate` in `app.dart` reacts to
  `isAuthenticated`. `LoginScreen` handles email/password sign-in and sign-up.
- Routes are string constants in `lib/routes/app_routes.dart`. Only `streak` is a
  named route now; login/shell are chosen by `AuthGate`.
- `AppShell` maps bottom-nav indices to screens: 0 Home, 1 Desafios, 4 Liga,
  5 Perfil. Indices 2/3 have no sketch and are no-ops. Add new tabs there.
- Adding a provider means registering it in `lib/main.dart` **and** the test
  helper in `test/widget_test.dart`.
- Static, non-user strings (section banner, challenge month/partner) live in
  `lib/data/app_constants.dart`, not in the DB.
- Shared widgets in `lib/widgets/`; screen-specific sub-widgets in
  `lib/screens/<feature>/widgets/`.
- `app.dart` sets `themeMode: ThemeMode.dark`; `LoginScreen` overrides with an
  explicit white surface.

## Testing quirks
- Tests must supply all 7 providers; `AppShell` uses `IndexedStack`, so every
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
