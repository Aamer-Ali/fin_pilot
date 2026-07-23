import 'package:flutter/material.dart';

/// Placeholder for the AI Insights tab. Real content (weekly AI-generated
/// summary, read-only from a Cloud Function doc — CLAUDE.md §4 `insights`,
/// Phase 4) lands last, after the core app works.
class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'AI Insights',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}