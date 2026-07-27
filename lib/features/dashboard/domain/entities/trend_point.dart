import 'package:equatable/equatable.dart';

/// One bar in the "Analytics Pulse" weekly spending trend.
class TrendPoint extends Equatable {
  const TrendPoint({required this.label, required this.amount});

  final String label;
  final double amount;

  @override
  List<Object?> get props => [label, amount];
}