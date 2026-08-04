import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/profile/domain/usecases/get_user_profile.dart';
import 'package:fin_pilot/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getUserProfile) : super(const ProfileState.initial());

  final GetUserProfileUseCase _getUserProfile;

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());
    final result = await _getUserProfile(const NoParams());
    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (profile) => emit(ProfileState.loaded(profile)),
    );
  }
}
