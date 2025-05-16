import 'package:flutter/material.dart';

class CustomRetry extends StatelessWidget {
  const CustomRetry({
    super.key,
    required this.error,
    this.stacktrace,
    required this.onRetry,
  });

  final Object error;
  final StackTrace? stacktrace;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Error: $error'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => onRetry?.call(),
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
