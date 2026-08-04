import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/features/auth/domain/entities/auth_tokens.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokens>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthTokens>> signup({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  });

  Future<Either<Failure, AuthTokens>> signInWithGoogle();

  Future<Either<Failure, AuthTokens>> signInWithApple();

  /// Reads the stored refresh token and exchanges it for a new token pair.
  Future<Either<Failure, AuthTokens>> refreshSession();

  Future<void> logout();

  /// Whether a token pair is currently stored on-device.
  Future<bool> hasStoredSession();
}
