import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_pilot/core/error/failures.dart';

/// Base type for every use case: one business action, one `call()`.
abstract class UseCase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

/// Marker params for use cases that take no arguments.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}