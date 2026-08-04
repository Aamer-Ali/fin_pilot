import 'package:fin_pilot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fin_pilot/features/auth/presentation/bloc/auth_event.dart';
import 'package:fin_pilot/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Placeholder for the Profile tab. Real content (biometric lock,
/// notifications, dark mode, linked accounts — CLAUDE.md §4 `profile`)
/// lands in a later step.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                'Profile',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () => {
                      context.read<AuthBloc>().add(LogoutRequested()),
                    },
                    child: Text("Logout"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
