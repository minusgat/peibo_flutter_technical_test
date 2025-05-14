import 'dart:developer';

import 'package:flutter/material.dart';

import 'result.dart'; // Tu implementación de Result

typedef RouteResult<T> = Result<T>; // Resultado genérico con datos

abstract class AppRouter {
  Future<RouteResult<T>> push<T>(WidgetBuilder builder);
}

class AppRouterImpl implements AppRouter {
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterImpl({required this.navigatorKey});

  NavigatorState get _navigator {
    if (navigatorKey.currentState == null) {
      throw FlutterError('Bad navigator key');
    }
    return navigatorKey.currentState!;
  }

  @override
  Future<RouteResult<T>> push<T>(WidgetBuilder builder) async {
    try {
      final result = await _navigator.push<T>(
        MaterialPageRoute<T>(builder: builder),
      );

      return result != null
          ? Result.success(result as T)
          : Result.failure('No result');
    } catch (e, st) {
      final message = 'Navigator error';
      log('Navigator error: $e');
      log('StackTrace: $st');
      log('Message: Navigator error');
      return Result.failure(message, Cause(e, st));
    }
  }
}
