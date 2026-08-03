import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:fin_pilot/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardSummary extends UseCase<DashboardSummary, NoParams> {
  GetDashboardSummary(this.repository);

  final DashboardRepository repository;

  @override
  Future<Either<Failure, DashboardSummary>> call(NoParams params) {
    return repository.getDashboardSummary();
  }
}
