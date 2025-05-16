import 'package:peibo_flutter_technical_test/chore/utils/result.dart';

mixin ResponseHandler {
  Result<T> handleResponse<T>(Result response, T Function(dynamic) decoder) {
    if (response.isFailure) {
      final message = response.asFailureOrNull()?.message ?? 'Request failed';
      return Result.failure(message);
    }

    final data = response.asSuccessOrNull()?.data;
    if (data == null) {
      return Result.failure('No data found');
    }

    return Result.success(decoder(data));
  }
}
