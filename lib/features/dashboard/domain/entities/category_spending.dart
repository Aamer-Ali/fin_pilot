import 'package:equatable/equatable.dart';

/// One slice of the "Spending Mix" donut — a category's share of outflow.
class CategorySpending extends Equatable {
  const CategorySpending({
    required this.category,
    required this.amount,
    required this.percentage,
  });

  final String category;
  final double amount;

  /// Share of total outflow, 0-100.
  final double percentage;

  @override
  List<Object?> get props => [category, amount, percentage];
}