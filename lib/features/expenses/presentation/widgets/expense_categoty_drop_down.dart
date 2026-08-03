import 'package:fin_pilot/core/theme/app_radius.dart';
import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:fin_pilot/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';

/// Card that shows the selected expense date and opens a date picker on
/// tap. Only past dates and today are selectable — no future dates.
class ExpenseDatePicker extends StatefulWidget {
  const ExpenseDatePicker({super.key, this.initialDate, this.onDateSelected});

  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateSelected;

  @override
  State<ExpenseDatePicker> createState() => _ExpenseDatePickerState();
}

class _ExpenseDatePickerState extends State<ExpenseDatePicker> {
  late DateTime _selectedDate = widget.initialDate ?? DateTime.now();

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked == null) return;
    setState(() => _selectedDate = picked);
    widget.onDateSelected?.call(picked);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: _pickDate,
      borderRadius: AppRadius.lgRadius,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.lgRadius,
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 24,
              color: colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date'.toUpperCase(),
                  style: AppTypography.labelMd.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  formatDateLabel(_selectedDate),
                  style: AppTypography.bodyLg.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              size: 24,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
