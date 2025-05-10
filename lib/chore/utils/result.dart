typedef EmptyResult = Result<EmptyContent>;

abstract class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure;

  const factory Result.success(T data) = Success;
  const factory Result.failure(String message, [Cause? cause]) = Failure;

  Success<T>? asSuccessOrNull() {
    if (!isSuccess) return null;

    return this as Success<T>;
  }

  Failure<T>? asFailureOrNull() {
    if (!isFailure) return null;

    return this as Failure<T>;
  }

  static EmptyResult emptySuccess() => const Success(EmptyContent());
}

class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.message, [this.failCause]);

  final String message;
  final Cause? failCause;

  @override
  String toString() => 'Failure{message: $message, failCause: $failCause}';
}

class Cause {
  const Cause(this.error, [this.stackTrace]);

  final dynamic error;
  final StackTrace? stackTrace;

  @override
  String toString() => 'Cause{error: $error, stackTrace: $stackTrace}';
}

class EmptyContent {
  const EmptyContent();
}
