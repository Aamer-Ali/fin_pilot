import 'package:fin_pilot/core/theme/app_radius.dart';
import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Large amount entry: label, `$` sign, editable value, and a stepper to
/// nudge the value up/down without opening the keyboard.
class AmountInput extends StatefulWidget {
  const AmountInput({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue = 0,
    this.step = 1,
    this.min = 0,
  });

  final TextEditingController? controller;
  final ValueChanged<double>? onChanged;
  final double initialValue;
  final double step;
  final double min;

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  late final TextEditingController _controller =
      widget.controller ??
      TextEditingController(text: _format(widget.initialValue));

  String _format(double value) => value.toStringAsFixed(2);

  double get _value => double.tryParse(_controller.text) ?? widget.min;

  void _setValue(double value) {
    final clamped = value < widget.min ? widget.min : value;
    _controller.text = _format(clamped);
    widget.onChanged?.call(clamped);
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Amount'.toUpperCase(),
          style: AppTypography.labelMd.copyWith(color: colorScheme.outline),
        ),
        SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.currency_rupee, size: 45, color: colorScheme.outline),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.4,
              ),
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                style: AppTypography.displayLg.copyWith(
                  color: colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  fillColor: colorScheme.surfaceContainer,
                ),
                onChanged: (text) => widget.onChanged?.call(_value),
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: AppRadius.smRadius,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _StepperButton(
                    icon: Icons.keyboard_arrow_up,
                    onTap: () => _setValue(_value + widget.step),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: colorScheme.outlineVariant,
                  ),
                  _StepperButton(
                    icon: Icons.keyboard_arrow_down,
                    onTap: () => _setValue(_value - widget.step),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
