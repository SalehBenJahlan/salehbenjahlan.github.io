import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// A card-level cursor spotlight effect.
/// Wraps [child] and paints a subtle radial gradient at the mouse position.
class CursorSpotlight extends StatefulWidget {
  final Widget child;
  final double radius;
  final Color? color;
  final BorderRadius borderRadius;

  const CursorSpotlight({
    required this.child,
    this.radius = 180,
    this.color,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    super.key,
  });

  @override
  State<CursorSpotlight> createState() => _CursorSpotlightState();
}

class _CursorSpotlightState extends State<CursorSpotlight> {
  Offset? _localPosition;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => _localPosition = event.localPosition),
      onExit: (_) => setState(() => _localPosition = null),
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Stack(
          children: [
            widget.child,
            if (_localPosition != null)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _SpotlightPainter(
                      position: _localPosition!,
                      radius: widget.radius,
                      color: widget.color ?? AppColors.purple.withValues(alpha: 0.08),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Offset position;
  final double radius;
  final Color color;

  _SpotlightPainter({
    required this.position,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withValues(alpha: 0)],
        stops: const [0.0, 1.0],
      ).createShader(
        Rect.fromCircle(center: position, radius: radius),
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _SpotlightPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}

/// Global page-level spotlight painter — very subtle.
class GlobalSpotlightPainter extends CustomPainter {
  final Offset position;
  final bool isDark;

  GlobalSpotlightPainter({required this.position, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    if (!isDark) return;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.purple.withValues(alpha: 0.04),
          AppColors.purple.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 1.0],
      ).createShader(
        Rect.fromCircle(center: position, radius: 400),
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant GlobalSpotlightPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}

