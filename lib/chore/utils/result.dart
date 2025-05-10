abstract class Result<T> {
  const Result();
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
