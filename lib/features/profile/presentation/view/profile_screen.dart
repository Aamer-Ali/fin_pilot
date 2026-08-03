import 'package:flutter/material.dart';

/// Placeholder for the Profile tab. Real content (biometric lock,
/// notifications, dark mode, linked accounts — CLAUDE.md §4 `profile`)
/// lands in a later step.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
