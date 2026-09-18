# AGENTS.md

Flutter app (Dart `^3.12.0`, Flutter 3.44) that clones the Duolingo mobile UI.
`docs/` holds 5 hand-drawn sketches (home, liga, desafios, perfil, rachas)
and is the **source of truth for UI**. Login + the 4 main tabs are implemented
through `AppShell`; the data is static mock (`lib/data/mock_data.dart`). A
future Supabase integration is planned: models carry `fromJson`/`toJson` so the
mock source can be swapped for repositories without touching the UI.

## Commands
- Install deps: `flutter pub get`
- Analyze (run before finishing): `flutter analyze`
- All tests: `flutter test`
- Single test: `flutter test test/widget_test.dart`
- Run app: `flutter run -d chrome` (or `-d windows`)
- Format: `dart format lib test`

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
- Entry flow: `lib/main.dart` (MultiProvider) -> `lib/app.dart` (themes +
  named routes) -> `lib/screens/shell/app_shell.dart` (bottom-nav tabs via
  `IndexedStack`) -> `lib/screens/<feature>/`. `StreakScreen` is pushed without
  the bottom nav.
- State: `provider` with `ChangeNotifier` in `lib/providers/`. No backend —
  data is hardcoded in `lib/data/mock_data.dart`; models in `lib/models/` carry
  `fromJson`/`toJson` to ease the future Supabase swap.
- Routes are string constants in `lib/routes/app_routes.dart`.
- Shared widgets in `lib/widgets/`; screen-specific sub-widgets in
  `lib/screens/<feature>/widgets/`.
- `app.dart` sets `themeMode: ThemeMode.dark`; `LoginScreen` overrides with an
  explicit white surface.

## Gotchas
- The Duo mascot is a `CustomPaint` placeholder. To use a real image, set
  `AppAssets.hasMascotAsset = true` and register `assets/images/duo.png` in
  `pubspec.yaml`.
- `README.md` is UTF-16 encoded; the Read tool reports it as binary — use
  `Get-Content` if needed.
- The Flutter template used Dart 3.12 dot-shorthands (`.fromSeed`, `.center`);
  either style is valid.
