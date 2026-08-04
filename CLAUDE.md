# FinPilot — Flutter Project Specification

> Feed this file to Claude Code as the single source of truth for scaffolding,
> building, and extending this project. It defines the design system, the
> architecture, the folder structure, and the build order. Follow it strictly
> unless the user explicitly says otherwise.

---

## 1. Project Overview

**FinPilot** is an expense & subscription tracking mobile app built to
demonstrate production-grade Flutter architecture. It is offline-first,
uses Clean Architecture with a strict Data/Domain/Presentation split per
feature, and is built incrementally: local-only first, Firebase second,
notifications third, AI last.

**Product framing (for copy/UX tone):** "Financial Clarity" — calm, minimal,
analytical-instrument feel. Not playful, not cluttered. Numbers are precise
and legible; whitespace does the work borders would otherwise do.

**Core user flows:**
1. Sign in (Google / Apple via Firebase Auth)
2. View dashboard — balance, monthly spending, spending mix, recent activity
3. Add an expense — amount, description, category (manual selection, no AI yet), optional receipt photo, date
4. Manage subscriptions/bills — recurring items with due dates and reminders
5. Get push notifications 1 day before a subscription is due
6. View AI-generated weekly insights (Phase 2 — build after core app works)
7. Manage profile/settings — biometric lock, notifications, dark mode, linked accounts

---

## 2. Design System

Implement this as a Flutter `ThemeData` / `ThemeExtension`, not hardcoded
colors scattered through widgets. Create `lib/core/theme/app_theme.dart`,
`app_colors.dart`, `app_typography.dart`, `app_spacing.dart`, `app_radius.dart`.

### 2.1 Color Palette (Light Mode)

| Token | Hex | Usage |
|---|---|---|
| `primary` | `#000000` | Primary buttons, headlines, key icons |
| `onPrimary` | `#FFFFFF` | Text/icons on primary |
| `primaryContainer` | `#131B2E` | Deep navy container surfaces |
| `onPrimaryContainer` | `#7C839B` | Text on primary container |
| `secondary` | `#505F76` | Slate blue — auxiliary info, inactive states |
| `onSecondary` | `#FFFFFF` | |
| `secondaryContainer` | `#D0E1FB` | |
| `onSecondaryContainer` | `#54647A` | |
| `tertiary` | `#000000` | Semantic accent base |
| `onTertiaryContainer` | `#009668` | **Emerald green** — positive values, growth, success only |
| `tertiaryContainer` | `#002113` | |
| `error` | `#BA1A1A` | |
| `onError` | `#FFFFFF` | |
| `errorContainer` | `#FFDAD6` | |
| `onErrorContainer` | `#93000A` | |
| `background` / `surface` | `#F7F9FB` | App background |
| `surfaceBright` | `#F7F9FB` | |
| `surfaceDim` | `#D8DADC` | |
| `surfaceContainerLowest` | `#FFFFFF` | Cards, inputs at rest→focus |
| `surfaceContainerLow` | `#F2F4F6` | Input backgrounds |
| `surfaceContainer` | `#ECEEF0` | |
| `surfaceContainerHigh` | `#E6E8EA` | |
| `surfaceContainerHighest` | `#E0E3E5` | |
| `onSurface` | `#191C1E` | Primary text |
| `onSurfaceVariant` | `#45464D` | Secondary text |
| `outline` | `#76777D` | Borders, muted labels |
| `outlineVariant` | `#C6C6CD` | Dividers |
| `inverseSurface` | `#2D3133` | |
| `inverseOnSurface` | `#EFF1F3` | |

### 2.2 Dark Mode
Base background `#020617` (deep charcoal), elevated surfaces lighten slightly
to `#1E293B` to indicate elevation. Maintain the same semantic role mapping
(primary/secondary/tertiary/error) — do not reinvent roles for dark mode,
only remap hex values. Use Flutter's `ColorScheme.dark()` seeded appropriately
and override via `ThemeExtension`.

### 2.3 Typography — Inter font family throughout

| Role | Size | Line Height | Weight | Letter Spacing | Usage |
|---|---|---|---|---|---|
| `displayLg` | 48px | 1.1 | 600 | -0.02em | Large amount inputs (Add Expense) |
| `headlineLg` | 32px | 40px | 600 | -0.01em | Desktop headlines |
| `headlineLgMobile` | 24px | 32px | 600 | -0.01em | Mobile headlines |
| `headlineMd` | 20px | 28px | 500 | — | Card titles, screen titles |
| `bodyLg` | 16px | 24px | 400 | — | Primary body text |
| `bodySm` | 14px | 20px | 400 | — | Secondary text, list descriptions |
| `labelMd` | 12px | 16px | 500 | 0.05em, UPPERCASE | Field labels, table headers, category tags |
| `dataMono` | 16px | 24px | 600 | — | **All financial figures** — use `FontFeature.tabularFigures()` so digit columns align |

Use Google Fonts package (`google_fonts`) to load Inter, or bundle the font
files locally under `assets/fonts/` and register in `pubspec.yaml`.

### 2.4 Spacing (4px baseline grid)

| Token | Value |
|---|---|
| `base` | 4px |
| `xs` | 4px |
| `sm` | 8px |
| `md` | 16px |
| `lg` | 24px |
| `xl` | 48px |
| `gutter` | 24px |

Sections of different financial categories should be separated by at least
`xl` (48px). Card internal padding = `lg` (24px).

### 2.5 Shape / Radius

| Token | Value | Usage |
|---|---|---|
| default/buttons/inputs | 8px (`0.5rem`) | Standard buttons, text inputs |
| `lg` (cards) | 16px (`1rem`) | Cards, major containers |
| `xl` | 24px (`1.5rem`) | Large containers (e.g. AI insight banner) |
| `full` | 9999px | Pills, chips, badges |

### 2.6 Elevation
No heavy borders. Depth = tonal shifts (background color changes between
`surface` → `surfaceContainerLowest` → `surfaceContainerLow`), supplemented
by very soft ambient shadows only on the elevated layer (modals, dropdowns):
`0px 4px 20px rgba(15, 23, 42, 0.08)`. Only use 1px `outlineVariant` dividers
when a tonal shift alone isn't enough to separate content.

### 2.7 Component Rules
- **Primary buttons:** solid `primary` background, `onPrimary` text, height 56px, radius 12-16px, `active:scale(0.98)` press feedback (`AnimatedScale` or `InkWell` with custom splash)
- **Secondary/ghost buttons:** transparent background, `secondary` text, no border, subtle background on hover/press
- **Inputs:** soft-filled — `surfaceContainerLow` background, no border at rest; on focus, transition to white background with a 1px `primary` border
- **Cards:** no borders, `surfaceContainerLowest` background, `lg` radius, `lg` internal padding
- **Chips/category tags:** pill-shaped (`full` radius), `secondaryContainer` background, `onSecondaryContainer` text, small leading icon
- **Lists (transactions):** description in `bodySm`, amount in `dataMono`; use `onTertiaryContainer` (emerald) strictly for positive/income values, default `onSurface` for expenses
- **Icons:** Material Symbols Outlined, 2px-equivalent stroke weight, consistent 24px sizing unless specified

---

## 3. Architecture — Clean Architecture (strict)

Every feature has exactly three layers. **No screen talks to Firestore/Hive
directly. No Bloc/Cubit imports a data source directly.** Dependencies point
inward only: `presentation → domain → data` is wrong; correct dependency
direction is `presentation → domain ← data`. Domain defines interfaces, data
implements them, presentation only knows domain.

```
Presentation  →  depends on →  Domain (entities, repository interfaces, use cases)
Data          →  implements →  Domain repository interfaces
```

### 3.1 Layer responsibilities

**`domain/`** (pure Dart, no Flutter/Firebase/Hive imports)
- `entities/` — plain Dart classes representing business objects (e.g. `Expense`)
- `repositories/` — abstract interfaces (e.g. `abstract class ExpenseRepository`)
- `usecases/` — one class per business action (e.g. `AddExpenseUseCase`, `WatchExpensesUseCase`), each with a single `call()` method

**`data/`**
- `models/` — DTOs that extend/convert to domain entities, with `fromJson`/`toJson`/`fromHive` (e.g. `ExpenseModel`)
- `datasources/` — `ExpenseLocalDataSource` (Hive), `ExpenseRemoteDataSource` (Firestore) — concrete, no abstraction needed at this level, they're already implementation detail
- `repositories/` — concrete implementation of the domain repository interface, orchestrates local + remote data sources (this is where offline-first logic — read local first, sync remote in background — lives)

**`presentation/`**
- `bloc/` (or `cubit/`) — `XCubit`/`XBloc` + `XState` (freezed), calls use cases only, never data sources or repositories directly
- `view/` — Screens (`XScreen`)
- `widgets/` — feature-local reusable widgets

### 3.2 Why this matters for this project specifically
This is what makes "Firestore today, REST API later" a one-file change:
only `data/repositories/expense_repository_impl.dart` changes. `domain/` and
`presentation/` never change when the backend changes.

---

## 4. Folder Structure

```
lib/
 ├── main.dart
 ├── app.dart                        # MaterialApp, theme, routing root
 │
 ├── core/
 │    ├── di/
 │    │    └── injector.dart         # get_it setup, registerLazySingleton etc.
 │    ├── theme/
 │    │    ├── app_theme.dart
 │    │    ├── app_colors.dart
 │    │    ├── app_typography.dart
 │    │    ├── app_spacing.dart
 │    │    └── app_radius.dart
 │    ├── network/
 │    │    └── connectivity_service.dart
 │    ├── error/
 │    │    ├── failures.dart         # sealed Failure classes (freezed)
 │    │    └── exceptions.dart
 │    ├── usecase/
 │    │    └── usecase.dart          # base UseCase<Type, Params> abstract class
 │    ├── routing/
 │    │    └── app_router.dart       # go_router setup
 │    └── utils/
 │         ├── date_formatter.dart
 │         └── currency_formatter.dart
 │
 ├── features/
 │    ├── auth/
 │    │    ├── data/
 │    │    │    ├── models/user_model.dart
 │    │    │    ├── datasources/auth_remote_datasource.dart
 │    │    │    └── repositories/auth_repository_impl.dart
 │    │    ├── domain/
 │    │    │    ├── entities/app_user.dart
 │    │    │    ├── repositories/auth_repository.dart
 │    │    │    └── usecases/sign_in_with_google.dart, sign_in_with_apple.dart, sign_out.dart
 │    │    └── presentation/
 │    │         ├── bloc/auth_bloc.dart, auth_event.dart, auth_state.dart
 │    │         ├── view/login_screen.dart, signup_screen.dart
 │    │         └── widgets/social_login_button.dart
 │    │
 │    ├── expenses/
 │    │    ├── data/
 │    │    │    ├── models/expense_model.dart
 │    │    │    ├── datasources/expense_local_datasource.dart (Hive)
 │    │    │    ├── datasources/expense_remote_datasource.dart (Firestore)
 │    │    │    └── repositories/expense_repository_impl.dart
 │    │    ├── domain/
 │    │    │    ├── entities/expense.dart
 │    │    │    ├── repositories/expense_repository.dart
 │    │    │    └── usecases/add_expense.dart, watch_expenses.dart, delete_expense.dart, sync_expenses.dart
 │    │    └── presentation/
 │    │         ├── cubit/expense_cubit.dart, expense_state.dart
 │    │         ├── view/add_expense_screen.dart
 │    │         └── widgets/amount_input.dart, category_selector.dart, receipt_picker.dart
 │    │
 │    ├── subscriptions/
 │    │    ├── data/ ...
 │    │    ├── domain/ ...
 │    │    └── presentation/
 │    │         ├── cubit/subscription_cubit.dart
 │    │         ├── view/subscriptions_screen.dart
 │    │         └── widgets/subscription_card.dart
 │    │
 │    ├── dashboard/
 │    │    ├── data/ (aggregation queries / rollup reads)
 │    │    ├── domain/ (GetDashboardSummary usecase)
 │    │    └── presentation/
 │    │         ├── cubit/dashboard_cubit.dart
 │    │         ├── view/home_screen.dart
 │    │         └── widgets/spending_mix_chart.dart, recent_activity_list.dart
 │    │
 │    ├── insights/                  # PHASE 2 — build after core app works, contains all AI logic
 │    │    ├── data/ (reads insights/{weekId} doc — written by Cloud Function, not client)
 │    │    ├── domain/
 │    │    └── presentation/
 │    │         ├── cubit/insights_cubit.dart
 │    │         └── view/weekly_pulse_screen.dart
 │    │
 │    └── profile/
 │         ├── data/ ...
 │         ├── domain/ ...
 │         └── presentation/
 │              ├── cubit/profile_cubit.dart
 │              └── view/profile_screen.dart
 │
 └── services/
      ├── notification_service.dart  # FCM + flutter_local_notifications, init in main.dart
      └── sync_service.dart          # workmanager background task registration
```

---

## 5. Local Storage Schema (Hive) — build this first

```dart
@HiveType(typeId: 0)
class ExpenseHiveModel {
  @HiveField(0) String id;
  @HiveField(1) double amount;
  @HiveField(2) String description;
  @HiveField(3) String category;
  @HiveField(4) String? receiptLocalPath;
  @HiveField(5) DateTime date;
  @HiveField(6) bool isSynced;      // false until confirmed written to Firestore
  @HiveField(7) DateTime createdAt;
}

@HiveType(typeId: 1)
class SubscriptionHiveModel {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) double amount;
  @HiveField(3) String billingCycle;   // "monthly" | "yearly"
  @HiveField(4) DateTime nextDueDate;
  @HiveField(5) String category;
  @HiveField(6) bool reminderEnabled;
  @HiveField(7) bool isSynced;
  @HiveField(8) DateTime createdAt;
}
```

Run `build_runner` to generate Hive adapters and register them in `main.dart`
before `runApp()`.

---

## 6. Firestore Schema (build this in Phase 2, after local works)

See the `firestore-schema` skill for the full document schema (users/{uid}
and its expenses, subscriptions, insights, and budgets subcollections) and
the security rule baseline.

---

## 7. State Management Conventions (Bloc/Cubit)

- Use **Cubit** for simple CRUD/state-holding features (expenses, subscriptions, profile)
- Use **Bloc** where there's meaningful event-driven complexity (auth flows with multiple triggers, sync coordination)
- All states are `sealed`/union types via **freezed**: `initial`, `loading`, `loaded(data)`, `error(Failure)` at minimum
- Cubits/Blocs depend on **use cases**, never on repositories or data sources directly
- Use `Equatable` or freezed's built-in equality — never rebuild UI unnecessarily
- `BlocProvider` scoped per-feature at the route level, not globally, unless truly app-wide (e.g. `AuthBloc`)
- Every Cubit/Bloc gets at least 3-5 `bloc_test` cases: initial state, success path, failure path

Example skeleton:
```dart
@freezed
class ExpenseState with _$ExpenseState {
  const factory ExpenseState.initial() = _Initial;
  const factory ExpenseState.loading() = _Loading;
  const factory ExpenseState.loaded(List<Expense> expenses) = _Loaded;
  const factory ExpenseState.error(String message) = _Error;
}

class ExpenseCubit extends Cubit<ExpenseState> {
  final AddExpenseUseCase addExpense;
  final WatchExpensesUseCase watchExpenses;
  ExpenseCubit({required this.addExpense, required this.watchExpenses})
      : super(const ExpenseState.initial());
  // ...
}
```

---

## 8. Package List

### Core / Architecture
| Package | Purpose |
|---|---|
| `flutter_bloc` | Bloc/Cubit state management |
| `equatable` | Value equality for states/entities (if not using freezed everywhere) |
| `freezed` + `freezed_annotation` | Immutable models, union state types |
| `json_serializable` + `json_annotation` | JSON (de)serialization for Firestore models |
| `get_it` | Service locator / dependency injection |
| `injectable` + `injectable_generator` | Codegen for get_it registration (optional but recommended) |
| `dartz` (or `fpdart`) | `Either<Failure, T>` for functional error handling in use cases |
| `build_runner` | Codegen runner (dev dependency) |

### Local Storage
| Package | Purpose |
|---|---|
| `hive` + `hive_flutter` | Local NoSQL storage, offline-first cache |
| `hive_generator` | Codegen for Hive TypeAdapters (dev dependency) |
| `path_provider` | File system paths for Hive boxes and receipt images |

### Firebase
| Package | Purpose |
|---|---|
| `firebase_core` | Firebase init |
| `firebase_auth` | Google/Apple sign-in |
| `google_sign_in` | Google auth flow |
| `sign_in_with_apple` | Apple auth flow |
| `cloud_firestore` | Firestore database |
| `firebase_storage` | Receipt image uploads |
| `firebase_messaging` | FCM push notifications |
| `cloud_functions` | Calling Cloud Functions (weekly insights, categorization later) |

### Notifications & Background
| Package | Purpose |
|---|---|
| `flutter_local_notifications` | Local notification display + scheduling |
| `workmanager` | Background sync tasks (Hive → Firestore) |
| `permission_handler` | Runtime notification permission (Android 13+) |

### Networking & Connectivity
| Package | Purpose |
|---|---|
| `dio` | HTTP client, wrapped behind repository (future REST swap-in) |
| `connectivity_plus` | Detect online/offline state to trigger sync |

### UI
| Package | Purpose |
|---|---|
| `google_fonts` | Inter font family |
| `fl_chart` | Spending mix donut chart, 7-day trend line chart |
| `go_router` | Declarative routing/navigation |
| `image_picker` | Camera/gallery receipt capture |
| `cached_network_image` | Profile photo / receipt image caching |
| `shimmer` | Loading skeletons |
| `local_auth` | Biometric app lock (FaceID/TouchID) |

### Testing
| Package | Purpose |
|---|---|
| `bloc_test` | Testing Cubits/Blocs |
| `mocktail` | Mocking repositories/use cases in tests |
| `flutter_test` | Standard widget/unit testing (SDK) |

---

## 9. Build Phases (do not skip ahead)

**Phase 1 — Local-only core (no Firebase, no AI, no notifications)**
1. Project scaffold: folder structure above, `pubspec.yaml` with Phase 1 packages only (bloc, freezed, get_it, hive, dio, connectivity_plus, fl_chart, go_router, google_fonts)
2. Theme system (`core/theme/*`) matching Section 2 exactly
3. `expenses` feature: entity → repository interface → Hive datasource → repository impl → use cases → `ExpenseCubit` → Add Expense screen + Home screen (static/local data), **no AI, manual category selector**
4. `subscriptions` feature: same pattern, local-only
5. Verify full offline CRUD works end-to-end before moving on

**Phase 2 — Firebase integration**
6. Create Firebase project, add config files, `firebase_core` init
7. Firebase Auth (Google + Apple) — `auth` feature, Login/Signup screens
8. `ExpenseRemoteDataSource` (Firestore) + update `ExpenseRepositoryImpl` to read local first, sync to Firestore in background when online (use `connectivity_plus` to trigger sync, `isSynced` flag in Hive model tracks state)
9. Repeat for `subscriptions`

**Phase 3 — Notifications**
10. `firebase_messaging` setup: foreground/background/terminated handlers, top-level background handler function
11. `flutter_local_notifications` for the "no expense logged today" daily nudge
12. Cloud Function (scheduled, daily) to check `nextDueDate` on subscriptions and trigger FCM push 1 day before due
13. `workmanager` registration for periodic background sync

**Phase 4 — AI (build last, fully isolated)**
14. Cloud Function: on-call categorization endpoint
15. Cloud Function: scheduled weekly insights generator, writes to `insights/{weekId}`
16. `insights` feature: Weekly Pulse screen reads that doc only — no AI call on client
17. Re-add AI categorization UI to Add Expense screen as a separate async event, never blocking the manual save path

---

## 10. Non-negotiable Rules for Claude Code

- Never let `presentation/` import anything from `data/` directly
- Never call Firestore/Hive from a Cubit/Bloc — always through a use case → repository
- Every new model needs a domain entity **and** a data model — do not reuse Firestore/Hive models as domain entities
- Every feature added must include all three layers, even if `domain/usecases` has just one file to start
- Match the design tokens in Section 2 exactly — no ad hoc hex colors or font sizes in widgets
- All financial figures use `dataMono` style with tabular figures
- Write at least minimal `bloc_test` coverage for each Cubit/Bloc before moving to the next feature
- Token efficiency is a hard requirement — see [`docs/AGENT_EFFICIENCY_RULES.md`](./docs/AGENT_EFFICIENCY_RULES.md) before running any Bash command
