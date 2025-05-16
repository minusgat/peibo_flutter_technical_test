import 'dart:math';

import 'package:flutter/material.dart';

class ShinyBouncingContainer extends StatefulWidget {
  const ShinyBouncingContainer({super.key, required this.child, this.loops});

  final Widget child;
  final int? loops;
  @override
  State<ShinyBouncingContainer> createState() => _ShinyBouncingContainerState();
}

class _ShinyBouncingContainerState extends State<ShinyBouncingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _shineAnim;
  int _completedLoops = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _scaleAnim = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.2,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 50,
      ),
    ]).animate(_controller);
    _shineAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.loops == null) {
      _controller.repeat(reverse: false);
    } else {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _completedLoops++;
          if (_completedLoops < (widget.loops ?? 0)) {
            _controller.forward(from: 0.0);
          }
        }
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AnimatedScale(
              scale: _scaleAnim.value,
              duration: Duration.zero,
              child: child,
            ),
            // Brillo animado
            Opacity(
              opacity: 0.5 * sin(pi * _shineAnim.value),
              child: IgnorePointer(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}
