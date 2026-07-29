import 'package:fin_pilot/core/theme/app_radius.dart';
import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/expense_categories.dart';
import 'package:flutter/material.dart';

/// Card that shows the selected expense category and opens a picker sheet
/// on tap. Categories are a static list for now (CLAUDE.md build order —
/// user-managed categories come later).
class ExpenseCategoryDropDown extends StatefulWidget {
  const ExpenseCategoryDropDown({
    super.key,
    this.initialCategory,
    this.onCategorySelected,
  });

  final String? initialCategory;
  final ValueChanged<String>? onCategorySelected;

  @override
  State<ExpenseCategoryDropDown> createState() =>
      _ExpenseCategoryDropDownState();
}

class _ExpenseCategoryDropDownState extends State<ExpenseCategoryDropDown> {
  late String? _selectedCategory = widget.initialCategory;

  Future<void> _pickCategory() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => _CategoryPickerSheet(selected: _selectedCategory),
    );
    if (picked == null) return;
    setState(() => _selectedCategory = picked);
    widget.onCategorySelected?.call(picked);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: _pickCategory,
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
              Icons.category_outlined,
              size: 24,
              color: colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category'.toUpperCase(),
                  style: AppTypography.labelMd.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  _selectedCategory ?? 'Select category',
                  style: AppTypography.bodyLg.copyWith(
                    color: _selectedCategory == null
                        ? colorScheme.outline
                        : colorScheme.onSurface,
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

class _CategoryPickerSheet extends StatelessWidget {
  const _CategoryPickerSheet({required this.selected});

  final String? selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Category', style: AppTypography.headlineMd),
            SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final category in expenseCategories)
                  ChoiceChip(
                    label: Text(category),
                    selected: category == selected,
                    selectedColor: colorScheme.primary,
                    labelStyle: AppTypography.labelMd.copyWith(
                      color: category == selected
                          ? colorScheme.onPrimary
                          : colorScheme.onSecondaryContainer,
                    ),
                    onSelected: (_) => Navigator.of(context).pop(category),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
