import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/features/profile/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getUserProfile();
}
