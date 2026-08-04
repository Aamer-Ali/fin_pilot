import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/profile/domain/entities/user_profile.dart';
import 'package:fin_pilot/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase extends UseCase<UserProfile, NoParams> {
  GetUserProfileUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) {
    return _repository.getUserProfile();
  }
}
