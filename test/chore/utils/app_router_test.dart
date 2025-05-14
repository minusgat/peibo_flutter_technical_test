import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peibo_flutter_technical_test/chore/utils/app_router.dart';

void main() {
  late final AppRouter subject;
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    subject = AppRouterImpl(navigatorKey: GlobalKey<NavigatorState>());
  });

  test('should throw FlutterError when navigatorKey is null', () async {
    final appRouter = subject;

    final result = await appRouter.push((context) => const SizedBox());

    expect(result.isFailure, true);
  });
}
