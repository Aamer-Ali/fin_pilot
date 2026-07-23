import 'package:fin_pilot/core/routing/app_router.dart';
import 'package:flutter/material.dart';

/// Placeholder for the Home tab. Real dashboard content (balance, spending
/// mix, recent activity — CLAUDE.md §4 `dashboard`) lands in a later step.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home', style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}