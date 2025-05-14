import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/chore/configuration/environment_configuration.dart';
import 'package:peibo_flutter_technical_test/chore/network/http/dio_client/dio_client.dart';
import 'package:peibo_flutter_technical_test/chore/utils/app_router.dart';

final dioApiClientProvider = Provider<DioApiClient>((ref) {
  return DioApiClient(dio: Dio(BaseOptions(baseUrl: Environment.apiUrl)));
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

final routerProvider = Provider<AppRouter>((ref) {
  return AppRouterImpl(navigatorKey: ref.read(navigatorKeyProvider));
});
