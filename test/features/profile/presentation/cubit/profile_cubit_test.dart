import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/profile/domain/entities/user_profile.dart';
import 'package:fin_pilot/features/profile/domain/usecases/get_user_profile.dart';
import 'package:fin_pilot/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fin_pilot/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUserProfileUseCase extends Mock implements GetUserProfileUseCase {}

void main() {
  late MockGetUserProfileUseCase getUserProfile;

  final profile = UserProfile(
    id: 'bf514280-4f0e-4ea9-b981-b331bd66ab55',
    email: 'aamer.techwork@gmail.com',
    firstName: 'Aamer',
    lastName: 'Sayyed',
    avatarUrl: null,
    provider: 'local',
    providerId: null,
    createdAt: DateTime.parse('2026-08-03T11:35:17.207Z'),
    updatedAt: DateTime.parse('2026-08-03T11:35:17.207Z'),
  );

  setUpAll(() {
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    getUserProfile = MockGetUserProfileUseCase();
  });

  ProfileCubit buildCubit() => ProfileCubit(getUserProfile);

  test('initial state is ProfileState.initial', () {
    expect(buildCubit().state, const ProfileState.initial());
  });

  blocTest<ProfileCubit, ProfileState>(
    'emits [loading, loaded] when the use case succeeds',
    setUp: () {
      when(
        () => getUserProfile(any()),
      ).thenAnswer((_) async => Right(profile));
    },
    build: buildCubit,
    act: (cubit) => cubit.loadProfile(),
    expect: () => [
      const ProfileState.loading(),
      ProfileState.loaded(profile),
    ],
  );

  blocTest<ProfileCubit, ProfileState>(
    'emits [loading, error] when the use case fails',
    setUp: () {
      when(() => getUserProfile(any())).thenAnswer(
        (_) async => const Left(Failure.unauthorized('Session expired.')),
      );
    },
    build: buildCubit,
    act: (cubit) => cubit.loadProfile(),
    expect: () => [
      const ProfileState.loading(),
      const ProfileState.error('Session expired.'),
    ],
  );

  blocTest<ProfileCubit, ProfileState>(
    'calls the use case with NoParams exactly once',
    setUp: () {
      when(
        () => getUserProfile(any()),
      ).thenAnswer((_) async => Right(profile));
    },
    build: buildCubit,
    act: (cubit) => cubit.loadProfile(),
    verify: (_) {
      verify(() => getUserProfile(const NoParams())).called(1);
    },
  );
}
