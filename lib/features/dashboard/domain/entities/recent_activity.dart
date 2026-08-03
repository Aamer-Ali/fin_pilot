import 'package:equatable/equatable.dart';

class RecentActivity extends Equatable {
  const RecentActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.amount,
    required this.isIncome,
  });

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final double amount;
  final bool isIncome;

  @override
  List<Object?> get props => [id, title, description, date, amount, isIncome];
}
