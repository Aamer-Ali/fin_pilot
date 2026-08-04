// Named constructor params intentionally read as `remote:`/`local:`/`social:`
// at call sites rather than the private `_remote:` an initializing formal
// would force.
// ignore_for_file: prefer_initializing_formals
import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/exceptions.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:fin_pilot/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fin_pilot/features/auth/data/datasources/auth_social_datasource.dart';
import 'package:fin_pilot/features/auth/data/models/auth_tokens_model.dart';
import 'package:fin_pilot/features/auth/domain/entities/auth_tokens.dart';
import 'package:fin_pilot/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
    required AuthSocialDataSource social,
  }) : _remote = remote,
       _local = local,
       _social = social;

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  final AuthSocialDataSource _social;

  @override
  Future<Either<Failure, AuthTokens>> login({
    required String email,
    required String password,
  }) {
    return _callAndStore(() => _remote.login(email: email, password: password));
  }

  @override
  Future<Either<Failure, AuthTokens>> signup({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  }) {
    return _callAndStore(
      () => _remote.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      ),
    );
  }

  @override
  Future<Either<Failure, AuthTokens>> signInWithGoogle() {
    return _callAndStore(() async {
      final identity = await _social.signInWithGoogle();
      print(identity);
      throw const NetworkException('Could not reach the server.');
      // return _remote.loginWithGoogle(
      //   idToken: identity.idToken,
      //   firstName: identity.firstName,
      //   lastName: identity.lastName,
      // );
    });
  }

  @override
  Future<Either<Failure, AuthTokens>> signInWithApple() {
    return _callAndStore(() async {
      final identity = await _social.signInWithApple();
      return _remote.loginWithApple(
        idToken: identity.idToken,
        firstName: identity.firstName,
        lastName: identity.lastName,
      );
    });
  }

  @override
  Future<Either<Failure, AuthTokens>> refreshSession() {
    return _callAndStore(() async {
      final refreshToken = await _local.getRefreshToken();
      if (refreshToken == null) {
        throw const UnauthorizedException('No stored session to refresh.');
      }
      return _remote.refresh(refreshToken: refreshToken);
    });
  }

  @override
  Future<void> logout() => _local.clearTokens();

  @override
  Future<bool> hasStoredSession() async {
    final refreshToken = await _local.getRefreshToken();
    return refreshToken != null;
  }

  Future<Either<Failure, AuthTokens>> _callAndStore(
    Future<AuthTokensModel> Function() call,
  ) async {
    try {
      final tokens = await call();
      await _local.saveTokens(tokens);
      return Right(tokens);
    } on UnauthorizedException catch (e) {
      return Left(Failure.unauthorized(e.message));
    } on NetworkException catch (e) {
      return Left(Failure.network(e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(e.message));
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }
}
