import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatusUseCase extends UseCase<bool, NoParams> {
  CheckAuthStatusUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final hasSession = await _repository.hasStoredSession();
    return Right(hasSession);
  }
}
