import 'package:flutter/material.dart';

/// Placeholder for the Bills tab. Real content (recurring subscriptions/
/// bills, due dates, reminders — CLAUDE.md §4 `subscriptions`) lands in a
/// later step.
class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Bills', style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}