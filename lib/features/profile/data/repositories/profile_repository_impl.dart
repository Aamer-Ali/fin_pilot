import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/exceptions.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:fin_pilot/features/profile/domain/entities/user_profile.dart';
import 'package:fin_pilot/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._remote);

  final ProfileRemoteDataSource _remote;

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final profile = await _remote.getProfile();
      return Right(profile);
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
