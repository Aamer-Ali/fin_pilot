import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:fin_pilot/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl(this.localDataSource);

  final DashboardLocalDataSource localDataSource;

  @override
  Future<Either<Failure, DashboardSummary>> getDashboardSummary() async {
    try {
      final model = await localDataSource.getDashboardSummary();
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }
}
