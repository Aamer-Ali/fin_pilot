import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/auth/domain/entities/auth_tokens.dart';
import 'package:fin_pilot/features/auth/domain/repositories/auth_repository.dart';

class SignInWithAppleUseCase extends UseCase<AuthTokens, NoParams> {
  SignInWithAppleUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthTokens>> call(NoParams params) {
    return _repository.signInWithApple();
  }
}
