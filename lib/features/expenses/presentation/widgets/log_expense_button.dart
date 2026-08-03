import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Primary "Log Expense" submit button plus the budget-attribution caption
/// below it. UI only — [onPressed] wiring comes later.
class LogExpenseButton extends StatelessWidget {
  const LogExpenseButton({super.key, this.onPressed, this.budgetMonth});

  final VoidCallback? onPressed;

  /// Defaults to the current month, e.g. "October".
  final String? budgetMonth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Log Expense'),
                SizedBox(width: AppSpacing.sm),
                const Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        // Text.rich(
        //   TextSpan(
        //     style: AppTypography.bodySm.copyWith(
        //       color: colorScheme.onSurfaceVariant,
        //     ),
        //     children: [
        //       const TextSpan(text: 'This will be added to your '),
        //       TextSpan(
        //         text: '$month Budget',
        //         style: TextStyle(
        //           fontWeight: FontWeight.w600,
        //           color: colorScheme.onSurface,
        //         ),
        //       ),
        //       const TextSpan(text: '.'),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
