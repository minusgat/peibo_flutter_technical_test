import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

typedef V<T> = T Function(Object? json);

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  const PaginatedResponse(
      {required this.count, required this.next, this.previous, this.results});

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    V<T> fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  final int count;
  final String next;
  final String? previous;
  final List<T>? results;
}
