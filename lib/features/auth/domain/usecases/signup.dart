import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/auth/domain/entities/auth_tokens.dart';
import 'package:fin_pilot/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase extends UseCase<AuthTokens, SignupParams> {
  SignupUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthTokens>> call(SignupParams params) {
    return _repository.signup(
      email: params.email,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}

class SignupParams extends Equatable {
  const SignupParams({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
  });

  final String email;
  final String password;
  final String? firstName;
  final String? lastName;

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}
