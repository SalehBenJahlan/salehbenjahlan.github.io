import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Animated counting widget — counts from 0 to [targetValue].
/// Starts animation when first built (could be enhanced with visibility detection).
class AnimatedCounter extends StatefulWidget {
  final int targetValue;
  final String suffix;
  final String label;
  final Duration duration;

  const AnimatedCounter({
    required this.targetValue,
    this.suffix = '',
    required this.label,
    this.duration = const Duration(milliseconds: 2000),
    super.key,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final value = (_animation.value * widget.targetValue).round();
        return Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradient.createShader(bounds),
              child: Text(
                '$value${widget.suffix}',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.grey300 : AppColors.dark500,
              ),
            ),
          ],
        );
      },
    );
  }
}

