---
name: scaffold-feature
description: Scaffold a new FinPilot feature's three Clean Architecture layers (domain/data/presentation) — entity, repository interface, use cases, Hive/Firestore datasources, repository impl, and Cubit/Bloc — matching CLAUDE.md Sections 3-4 exactly. Use when adding a new feature (e.g. expenses, subscriptions, budgets, insights) or a new entity within an existing feature.
---

# Scaffold Feature

Creates the full `lib/features/<name>/` tree for a new FinPilot feature, or adds
a new entity to an existing feature, per the project's CLAUDE.md.

## Before generating anything

Confirm with the user (skip only if already answered in the request):
- Feature name and primary entity name(s)
- Current build phase for this feature: Phase 1 (local-only, Hive) or Phase 2+
  (add Firestore remote datasource too) — see CLAUDE.md Section 9
- Cubit vs Bloc — default to Cubit per Section 7 unless there's genuine
  event-driven complexity (multiple triggers, sync coordination)

## Files to create

**`domain/`** (pure Dart — no `flutter`, `hive`, or `cloud_firestore` imports)
- `entities/<entity>.dart`
- `repositories/<feature>_repository.dart` — abstract interface only
- `usecases/<verb>_<entity>.dart` — one class per action, exactly one public
  `call()` method, extends the `UseCase<Type, Params>` base from
  `core/usecase/usecase.dart`

**`data/`**
- `models/<entity>_model.dart` — DTO with `fromJson`/`toJson`/`fromHive`,
  converts to/from the domain entity (never reuse one class as both)
- `datasources/<feature>_local_datasource.dart` (Hive) — always
- `datasources/<feature>_remote_datasource.dart` (Firestore) — only if Phase 2+
- `repositories/<feature>_repository_impl.dart` — implements the domain
  interface; if remote exists, read local first and sync remote in the
  background (offline-first), otherwise local-only

**`presentation/`**
- `cubit/<feature>_cubit.dart` + `<feature>_state.dart` — freezed sealed
  union: `initial`, `loading`, `loaded(data)`, `error(Failure)` minimum.
  Depends only on use cases, never repositories or datasources directly.
- `view/<feature>_screen.dart` — screen stub
- `widgets/` — feature-local widgets as needed

## Wiring

1. Register the new datasource(s), repository, use cases, and a cubit
   factory in `core/di/injector.dart` (get_it).
2. If a new Hive model is involved, pick the next unused `@HiveType(typeId: N)`
   (check existing models first — don't reuse an ID), register the adapter in
   `main.dart` before `runApp()`, and run
   `dart run build_runner build --delete-conflicting-outputs`.
3. Use the design tokens in `core/theme/*` for any UI — never hardcode hex
   colors or ad hoc `TextStyle`s. Financial figures use `dataMono` with
   `FontFeature.tabularFigures()`.
4. Write 3-5 `bloc_test` cases for the new Cubit/Bloc: initial state, success
   path, failure path — per Section 7.

## Non-negotiables (CLAUDE.md Section 10 — do not skip under time pressure)

- `presentation/` never imports from `data/` directly.
- Cubit/Bloc never calls Hive/Firestore directly — only through a use case.
- Every model needs both a domain entity and a data model.
- No ad hoc colors/fonts outside `core/theme/`.

## When done

Run `flutter analyze` on the new/changed files and fix any errors before
reporting the feature as scaffolded.
