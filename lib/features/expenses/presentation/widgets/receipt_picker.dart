import 'package:fin_pilot/core/theme/app_radius.dart';
import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// "RECEIPT" label with two tappable options (Camera / Gallery) to attach
/// a receipt photo. UI only — wiring to image_picker comes later.
class ReceiptPicker extends StatelessWidget {
  const ReceiptPicker({super.key, this.onCameraTap, this.onGalleryTap});

  final VoidCallback? onCameraTap;
  final VoidCallback? onGalleryTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Receipt'.toUpperCase(),
          style: AppTypography.labelMd.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _ReceiptOption(
                icon: Icons.camera_alt_outlined,
                label: 'Camera',
                onTap: onCameraTap,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _ReceiptOption(
                icon: Icons.image_outlined,
                label: 'Gallery',
                onTap: onGalleryTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ReceiptOption extends StatelessWidget {
  const _ReceiptOption({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.lgRadius,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.lgRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: colorScheme.onSurface),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: AppTypography.bodyLg.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
