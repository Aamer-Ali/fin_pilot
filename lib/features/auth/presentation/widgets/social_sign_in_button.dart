import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// A full-width outlined button for a social sign-in provider (Google,
/// Apple). Purely presentational — [onPressed] wiring comes from outside.
class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            SizedBox(width: AppSpacing.sm),
            Text(label),
          ],
        ),
      ),
    );
  }
}
