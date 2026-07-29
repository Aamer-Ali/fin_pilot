import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  const Expense({
    required this.id,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    required this.createdAt,
    this.receiptLocalPath,
  });

  final String id;
  final double amount;
  final String description;
  final String category;
  final DateTime date;
  final DateTime createdAt;
  final String? receiptLocalPath;

  @override
  List<Object?> get props => [
    id,
    amount,
    description,
    category,
    date,
    createdAt,
    receiptLocalPath,
  ];
}
