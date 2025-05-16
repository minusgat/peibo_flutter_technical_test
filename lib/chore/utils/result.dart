import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

typedef EmptyResult = Result<EmptyContent>;

@freezed
abstract class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String message, [Cause? cause]) = Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  Success<T>? asSuccessOrNull() {
    if (!isSuccess) return null;
    return this as Success<T>;
  }

  Failure<T>? asFailureOrNull() {
    if (!isFailure) return null;
    return this as Failure<T>;
  }

  static EmptyResult emptySuccess() => const Result.success(EmptyContent());
}

@freezed
abstract class Cause with _$Cause {
  const factory Cause(dynamic error, [StackTrace? stackTrace]) = _Cause;
}

extension FailureX<T> on Failure<T> {
  Cause? get failCause => cause;
}

class EmptyContent {
  const EmptyContent();
}
