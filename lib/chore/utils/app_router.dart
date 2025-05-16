import 'dart:developer';

import 'package:flutter/material.dart';

import 'result.dart';

typedef RouteResult<T> = Result<T>;

abstract class AppRouter {
  Future<RouteResult<T>> push<T>(WidgetBuilder builder);
  //back
  void pop<T>([T? result]);
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

  @override
  void pop<T>([T? result]) {
    try {
      return _navigator.pop<T>(result);
    } catch (e, st) {
      final message = 'Navigator error';
      log('Navigator error: $e');
      log('StackTrace: $st');
      log('Message: Navigator error');
      throw FlutterError(message);
    }
  }
}
