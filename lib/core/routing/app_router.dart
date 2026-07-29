import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/view/home_screen.dart';
import '../../features/expenses/presentation/view/add_expense_screen.dart';
import '../../features/insights/presentation/view/insights_screen.dart';
import '../../features/profile/presentation/view/profile_screen.dart';
import '../../features/subscriptions/presentation/view/subscriptions_screen.dart';

/// App-wide navigation config.
///
/// `StatefulShellRoute.indexedStack` is go_router's built-in pattern for a
/// bottom-nav-with-tabs layout: each tab ("branch" below) gets its own URL
/// and its own independent navigation stack, and all four are kept alive in
/// an [IndexedStack] so switching tabs doesn't lose scroll position or
/// whatever screen you'd pushed on top within a tab. `builder` describes the
/// shared frame (the [Scaffold] + bottom nav bar) that wraps whichever tab
/// is currently showing.
///
///
final scaffoldKey = GlobalKey<ScaffoldState>();
final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _RootScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bills',
              builder: (context, state) => const SubscriptionsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/insights',
              builder: (context, state) => const InsightsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/add-expense',
      builder: (context, state) => const AddExpenseScreen(),
    ),
    GoRoute(path: '/settings', builder: (context, state) => const Text("asdf")),
    GoRoute(
      path: '/codes',
      builder: (context, state) => const Text("asfdasdf"),
    ),
  ],
);

/// The shared shell: shows the active tab's content plus the bottom nav bar.
///
/// [navigationShell] is what go_router hands the `builder` above — it knows
/// which branch (tab) is selected (`currentIndex`) and how to switch to
/// another one (`goBranch`).
class _RootScaffold extends StatelessWidget {
  const _RootScaffold({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  // static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // drawer: _AppDrawer(),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // Tapping the tab you're already on resets it back to its first
          // screen, instead of doing nothing.
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Bills',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'AI Insights',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

//
// class _AppDrawer extends StatelessWidget {
//   const _AppDrawer();
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             // const DrawerHeader(child: Text('FinPilot')),
//             ListTile(
//               leading: const Icon(Icons.settings_outlined),
//               title: const Text('Settings'),
//               onTap: () {
//                 Navigator.of(context).pop(); // close the drawer first
//                 context.push('/settings');
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.code_outlined),
//               title: const Text('Codes'),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 context.push('/codes');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
