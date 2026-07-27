import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:fin_pilot/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:fin_pilot/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:fin_pilot/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDashboardSummary extends Mock implements GetDashboardSummary {}

void main() {
  late MockGetDashboardSummary getDashboardSummary;

  const summary = DashboardSummary(
    totalBalance: 42950,
    monthlySpending: 17370,
    outflowPercentage: 82,
    spendingMix: [],
    weeklyTrend: [],
    insightText: 'insight',
    spendingChangePercent: -12,
    recentActivities: [],
  );

  setUpAll(() {
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    getDashboardSummary = MockGetDashboardSummary();
  });

  DashboardCubit buildCubit() => DashboardCubit(getDashboardSummary);

  test('initial state is DashboardState.initial', () {
    expect(buildCubit().state, const DashboardState.initial());
  });

  blocTest<DashboardCubit, DashboardState>(
    'emits [loading, loaded] when the use case succeeds',
    setUp: () {
      when(
        () => getDashboardSummary(any()),
      ).thenAnswer((_) async => const Right(summary));
    },
    build: buildCubit,
    act: (cubit) => cubit.loadDashboard(),
    expect: () => [
      const DashboardState.loading(),
      const DashboardState.loaded(summary),
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
    'emits [loading, error] when the use case fails',
    setUp: () {
      when(() => getDashboardSummary(any())).thenAnswer(
        (_) async => const Left(Failure.unexpected('something went wrong')),
      );
    },
    build: buildCubit,
    act: (cubit) => cubit.loadDashboard(),
    expect: () => [
      const DashboardState.loading(),
      const DashboardState.error('something went wrong'),
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
    'calls the use case with NoParams exactly once',
    setUp: () {
      when(
        () => getDashboardSummary(any()),
      ).thenAnswer((_) async => const Right(summary));
    },
    build: buildCubit,
    act: (cubit) => cubit.loadDashboard(),
    verify: (_) {
      verify(() => getDashboardSummary(const NoParams())).called(1);
    },
  );
}