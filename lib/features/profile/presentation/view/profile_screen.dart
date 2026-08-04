import 'package:fin_pilot/core/di/injector.dart';
import 'package:fin_pilot/core/theme/app_radius.dart';
import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:fin_pilot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fin_pilot/features/auth/presentation/bloc/auth_event.dart';
import 'package:fin_pilot/features/auth/presentation/bloc/auth_state.dart';
import 'package:fin_pilot/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fin_pilot/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Profile tab: user identity + support/legal links + logout.
///
/// Opening this screen triggers `GET users/profile` via [ProfileCubit].
/// Avatar isn't rendered yet — the backend doesn't return a usable image
/// today (`avatarUrl` is always null); only name + email are shown.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state case ProfileError(:final message)) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  }
                },
                builder: (context, state) {
                  return switch (state) {
                    ProfileInitial() || ProfileLoading() => const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    ProfileLoaded(:final profile) => _ProfileHeader(
                      name: '${profile.firstName} ${profile.lastName}',
                      email: profile.email,
                    ),
                    ProfileError(:final message) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xl,
                      ),
                      child: Center(
                        child: Text(message, style: AppTypography.bodyLg),
                      ),
                    ),
                  };
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              const _SupportLegalSection(),
              const SizedBox(height: AppSpacing.xl),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return _LogoutButton(
                    onPressed: () =>
                        context.read<AuthBloc>().add(LogoutRequested()),
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

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.name, required this.email});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          name,
          style: AppTypography.headlineMd.copyWith(color: colorScheme.onSurface),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          email,
          style: AppTypography.bodySm.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _SupportLegalSection extends StatelessWidget {
  const _SupportLegalSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SUPPORT & LEGAL',
          style: AppTypography.labelMd.copyWith(color: colorScheme.outline),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: AppRadius.lgRadius,
          ),
          child: Column(
            children: [
              _SupportLegalTile(
                icon: Icons.help_outline,
                label: 'Help Center',
                trailing: Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: colorScheme.outline,
                ),
                onTap: () {},
              ),
              Divider(
                height: 1,
                indent: AppSpacing.lg,
                endIndent: AppSpacing.lg,
                color: colorScheme.outlineVariant,
              ),
              _SupportLegalTile(
                icon: Icons.description_outlined,
                label: 'Terms of Service',
                trailing: Icon(
                  Icons.chevron_right,
                  color: colorScheme.outline,
                ),
                onTap: () {},
              ),
              Divider(
                height: 1,
                indent: AppSpacing.lg,
                endIndent: AppSpacing.lg,
                color: colorScheme.outlineVariant,
              ),
              _SupportLegalTile(
                icon: Icons.shield_outlined,
                label: 'Privacy Policy',
                trailing: Icon(
                  Icons.chevron_right,
                  color: colorScheme.outline,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SupportLegalTile extends StatelessWidget {
  const _SupportLegalTile({
    required this.icon,
    required this.label,
    required this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.lgRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyLg.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.logout),
      label: const Text('Logout'),
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.errorContainer,
        foregroundColor: colorScheme.onErrorContainer,
        minimumSize: const Size.fromHeight(56),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgRadius),
        textStyle: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
