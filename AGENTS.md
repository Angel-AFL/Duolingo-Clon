# AGENTS.md

Flutter app (Dart `^3.12.0`, Flutter 3.44) that clones the Duolingo mobile UI.
`docs/` holds 5 hand-drawn sketches (home, liga, desafios, perfil, rachas)
and is the **source of truth for UI**, pero donde el boceto difiera del
Duolingo real **manda el Duolingo real** (relieve 3D, burbuja EMPEZAR,
sendero del camino, banda de feedback solida, corazones). Login + the 4 main
tabs are implemented through `AppShell`. Data comes from **Supabase** through repositories
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
- Regenerate localizations after editing `lib/l10n/app_es.arb`: `flutter gen-l10n`
  (runs automatically on `pub get`/build because of `generate: true`).
- Format: `dart format lib test` (Dart 3.12 formatter rewrites the whole tree;
  expect unrelated formatting-only diffs)

## Design system (load the `duolingo` skill first)
- The `duolingo` skill only defines the **light marketing** theme. The app
  screens in `docs/` are **dark**, so `lib/core/theme/app_colors.dart` adds a
  documented `dark*` extension. Login stays light, app screens dark.
- Never hardcode colors/spacing/text styles. Use `AppColors`, `AppTypography`,
  `AppSpacing`/`AppRadius` (`lib/core/theme/`). Radii son 12px (componentes)
  o 16px (`AppRadius.button`) para botones/fichas.
- **Relieve 3D**: los botones y fichas usan el lip solido de Duolingo (borde
  inferior `0 4px 0` en un tono mas oscuro, `AppSpacing.lip` + `*Lip`). Usa
  `DuoButton` (`lib/widgets/duo_button.dart`; variantes primary/secondary/
  secondaryError/error/streak/blue/purple) y `DuoChoiceTile`
  (`lib/widgets/duo_choice_tile.dart`) para ejercicios. `PrimaryButton`/
  `SecondaryButton` son wrappers de `DuoButton`. El lip se colapsa al pulsar.
- **Iconos del nav**: `DuoNavIcon` (`lib/widgets/duo_nav_icon.dart`) dibuja los
  iconos multicolor de Duolingo con `CustomPaint` (casa, mision, trofeo, persona);
  `starPath` es un helper reutilizable. No usa `IconData`.
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
- Perfil (vitrina): `ProfileScreen` mantiene la cabecera amarilla y añade Súper
  familia (`SuperFamilyRow`), Medallas mensuales (`MedalsRow`) y Logros
  (`AchievementsRow`); los datos estaticos viven en `MockData.profileShowcase`
  (`lib/models/profile_showcase.dart`). Son placeholders (`AvatarCircle`/`Icon`),
  no hay assets de personajes.
- Auth: `AuthProvider` wraps `AuthRepository`; `AuthGate` in `app.dart` reacts to
  `isAuthenticated`. `LoginScreen` handles email/password sign-in and sign-up.
  Cerrar sesion se dispara desde el boton al final del perfil (con confirmacion).
- Routes are string constants in `lib/routes/app_routes.dart`. Only `streak` and
  `lesson` are named routes; login/shell are chosen by `AuthGate`. `lesson`
  receives the node position via `ModalRoute.settings.arguments`.
- Lecciones: al tocar un nodo `active` o `completed` del home se abre
  `LessonScreen` (sin bottom nav), que carga los ejercicios de `lesson_exercises`
  (o `MockData.lessonExercises`) via `LessonProvider`. La barra superior usa
  `LessonProgressBar`, que avanza al pulsar continuar (no al comprobar) y colorea
  cada ejercicio (verde acierto, rojo error, gris pendiente). La top bar muestra
  los corazones de `UserStatsProvider`; cada error consume uno (`onChecked` en
  `LessonProvider`) y a 0 se bloquea la leccion con la vista sin corazones
  (RECARGAR/SALIR). El feedback es una banda solida verde/roja
  (`LessonFeedbackBar`) con boton 3D. Al terminar siempre
  suma EXP con `ChallengesProvider.recordLesson(LessonOutcome)` (que avanza cada
  reto segun su metrica `exp`/`streak`/`accuracy`), y tambien con
  `ProfileProvider.addExp()` y `LeagueProvider.addExp()`; solo llama a
  `LearningPathProvider.completeCurrent()` si la leccion jugada era el nodo activo
  (repetir una completada no avanza el camino). Aplicar
  `supabase/migrations/0004_lesson_exercises.sql` para la tabla y el seed,
  `0005_normalize_lesson_nodes.sql` si alguna cuenta tiene el camino invertido, y
  `0006_reset_lesson_progress.sql` si quedo sin nodo activo (todo `completed`).
  `0007_challenge_metrics.sql` agrega `daily_challenges.metric` y ajusta el seed.
- Desafios: `ChallengesScreen` usa la cabecera naranja (`ChallengesHeader`) y la
  seccion `FriendChallengeCard` (reto de EXP entre amigos: Tú vs. partner, meta,
  cofre y botones DAR TOQUE/ENVIADO). Los valores estaticos viven en
  `AppConstants` y el estado `cheered`/`gifted` en `ChallengesProvider`.
- Estado de carga/error: los providers usan el mixin `LoadableProvider`
  (`lib/providers/loadable_provider.dart`) que expone `isLoading`/`hasLoaded`/
  `hasError`/`error` (y `hasWriteError`/`writeError` para guardados). Las
  pantallas muestran skeletons (`lib/widgets/skeleton.dart`) durante la primera
  carga y `ErrorRetryView` (`lib/widgets/error_retry_view.dart`) si falla.
- Escrituras de EXP: `profile` y `league` usan RPC atomicos
  (`increment_profile_exp` / `increment_league_exp`); aplicar
  `supabase/migrations/0008_atomic_exp.sql`. Los providers actualizan la UI de
  forma optimista y revierten + exponen `writeError` si el guardado falla.
- i18n: todos los textos de UI viven en `lib/l10n/app_es.arb` y se leen con
  `AppLocalizations.of(context)`; fechas/numeros con `intl`
  (`initializeDateFormatting('es')` en `main.dart`). No hardcodear strings.
- Tema: los estilos de componentes (botones, inputs, sheets, dialogs...) se
  centralizan en `lib/core/theme/app_theme.dart`; los widgets no repiten estilos.
- Accesibilidad: controles solo-icono y `GestureDetector` llevan
  `Semantics`/`Tooltip` (nav, nodos, presets de avatar, chips, rachas).
- `AppShell` tiene 4 pestanas (0 Home, 1 Desafios, 2 Liga, 3 Perfil) y el
  indice del nav es directamente el de la pantalla. Los iconos son dibujados
  con `DuoNavIcon` (`lib/widgets/duo_nav_icon.dart`), no `IconData`. Add new
  tabs there (y en `NavItem`/l10n).
- Home: `HomeScreen` usa `CustomScrollView` con el banner de seccion fijo
  (`SliverPersistentHeader`) y `LessonPath`, que pinta el sendero con
  `LessonPathPainter` y nodos 3D (`LessonNodeTile`). El nodo activo late
  (1.0->1.05 cada 1.6s) y muestra la burbuja EMPEZAR; respeta "reducir
  movimiento" (`MediaQuery.disableAnimations`) para no bloquear `pumpAndSettle`.
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
- `setUpAll` sets `accessibilityFeaturesTestValue.disableAnimations = true`:
  sin eso el pulso del nodo activo impide que `pumpAndSettle` termine.
- El banco de palabras puede quedar bajo el pie en la superficie de test; usa
  `tester.ensureVisible` antes de tocar fichas.
- El usuario mock es Súper (`hasUnlimitedHearts`), asi que los corazones no
  bajan por defecto; los tests de corazones inyectan un `UserStatsRepository`
  sin Súper (ver `_appWithStats`).

## Gotchas
- The Duo mascot is a `CustomPaint` placeholder. To use a real image, set
  `AppAssets.hasMascotAsset = true` and register `assets/images/duo.png` in
  `pubspec.yaml`.
- `README.md` contains null bytes, so the Read tool reports it as binary — use
  `Get-Content` if you need its contents.
- The Flutter template used Dart 3.12 dot-shorthands (`.fromSeed`, `.center`);
  either style is valid.
