# FinPilot Build Status

Tracks actual progress against the phase plan in `CLAUDE.md` Section 9.
Update this whenever a build step below is completed or started — this file
is checked into git so it stays in sync across machines/sessions, unlike
per-session memory.

## Phase 1 — Local-only core

- [x] Step 1: Project scaffold, Phase 1 packages in `pubspec.yaml`
      (flutter_bloc, equatable, freezed_annotation, json_annotation, get_it,
      dartz, hive/hive_flutter, path_provider, dio, connectivity_plus,
      google_fonts, fl_chart, go_router)
- [x] Step 2: Theme system (`core/theme/app_theme.dart`, `app_colors.dart`,
      `app_typography.dart`, `app_spacing.dart`, `app_radius.dart`)
- [x] `core/routing/app_router.dart` — go_router `StatefulShellRoute` wiring
      the 4 bottom-nav tabs (Home/Bills/AI Insights/Profile → the
      `dashboard`/`subscriptions`/`insights`/`profile` features). Each tab is
      currently a placeholder screen (`view/*_screen.dart`) showing only its
      centered title — no domain/data layers yet since there's no logic or
      data to model. Add those layers when each feature gets real content.
- [ ] Step 3: `expenses` feature (entity → repository interface → Hive
      datasource → repository impl → use cases → `ExpenseCubit` → Add Expense
      screen + real `dashboard` home content, manual category selector, no AI)
- [ ] Step 4: `subscriptions` feature real content (same pattern, local-only)
- [ ] Step 5: Verify full offline CRUD end-to-end

## Not yet started

- `core/di/injector.dart` (get_it wiring)
- `core/error/` (failures.dart, exceptions.dart)
- `core/usecase/usecase.dart` (base UseCase class)
- `core/network/connectivity_service.dart`
- `core/utils/` (date/currency formatters)
- Dev deps still missing from `pubspec.yaml`: `freezed`, `build_runner`,
  `json_serializable`, `hive_generator`, `bloc_test`, `mocktail` — add when
  the first feature (expenses) is scaffolded, since that's when codegen and
  tests are first needed
- Phases 2 (Firebase), 3 (Notifications), 4 (AI) — not started, do not build
  ahead of Phase 1 per Section 9

## Notes for future sessions

- Use the `scaffold-feature` skill (`.claude/skills/scaffold-feature/`) to
  generate a new feature's three layers consistently.
- Run the `architecture-guard` agent (`.claude/agents/architecture-guard.md`)
  after scaffolding or modifying a feature to catch Section 10 rule
  violations before moving on.