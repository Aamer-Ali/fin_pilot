import 'package:fin_pilot/core/theme/app_radius.dart';
import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Card with a "DESCRIPTION" label and a soft-filled multiline text field.
class DescriptionCard extends StatelessWidget {
  const DescriptionCard({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.lgRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description'.toUpperCase(),
            style: AppTypography.labelMd.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          TextField(
            controller: controller,
            onChanged: onChanged,
            minLines: 3,
            maxLines: 3,
            style: AppTypography.bodyLg.copyWith(color: colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: 'What was this for?',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
