import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/dashboard_summary.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardSummary>> getDashboardSummary();
}
