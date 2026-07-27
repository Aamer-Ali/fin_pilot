import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Sealed failure union returned by repositories via `Either<Failure, T>`.
/// Add new cases here as new failure sources appear (network, auth, ...).
@freezed
sealed class Failure with _$Failure {
  const factory Failure.cache(String message) = CacheFailure;
  const factory Failure.unexpected(String message) = UnexpectedFailure;
}

extension FailureMessage on Failure {
  String get message => switch (this) {
    CacheFailure(:final message) => message,
    UnexpectedFailure(:final message) => message,
  };
}