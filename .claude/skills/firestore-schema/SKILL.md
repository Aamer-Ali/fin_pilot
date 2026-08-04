---
name: firestore-schema
description: Firestore document schema for FinPilot's Phase 2 (Firebase integration) — users/{uid} and its expenses, subscriptions, insights, and budgets subcollections, plus the security rule baseline. Use when building ExpenseRemoteDataSource, SubscriptionRemoteDataSource, insights, budgets, or any other Firestore-backed data source, or when writing Firestore security rules.
---

# Firestore Schema (Phase 2)

Build this after local-only (Hive) CRUD works end-to-end. See `CLAUDE.md`
Section 9 for build phase ordering.

```
users/{uid}
  displayName, email, photoUrl
  subscriptionPlan: "premium" | "free"
  linkedAccounts: [string]
  preferences: { biometricLock: bool, notificationsEnabled: bool, darkMode: bool }
  createdAt, updatedAt

users/{uid}/expenses/{expenseId}
  amount: number
  description: string
  category: string
  receiptUrl: string?
  date: Timestamp
  createdAt: Timestamp

users/{uid}/subscriptions/{subId}
  name: string
  amount: number
  billingCycle: "monthly" | "yearly"
  nextDueDate: Timestamp
  category: string
  reminderEnabled: bool
  createdAt: Timestamp

users/{uid}/insights/{weekId}        # "2026-W29" — written by Cloud Function only
  summaryText: string
  periodStart, periodEnd: Timestamp
  dailyTotals: [{day, amount}]
  topCategories: [{name, amount, transactionCount, changePercent}]
  nextWeekTip: string
  generatedAt: Timestamp

users/{uid}/budgets/{monthId}        # "2026-07" — rollup, written by Cloud Function or client
  totalBudget: number
  totalSpent: number
  categoryBreakdown: { [category: string]: number }
```

**Security rule baseline:**
```
match /users/{uid}/{document=**} {
  allow read, write: if request.auth != null && request.auth.uid == uid;
}
```
