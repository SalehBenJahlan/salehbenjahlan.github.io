import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// A single technology tile for the Skills grid.
/// Features hover elevation, translateY, glow shadow, and local cursor spotlight.
class TechTile extends StatefulWidget {
  final IconData icon;
  final String name;
  final Color iconColor;
  final bool isDark;

  const TechTile({
    required this.icon,
    required this.name,
    required this.iconColor,
    required this.isDark,
    super.key,
  });

  @override
  State<TechTile> createState() => _TechTileState();
}

class _TechTileState extends State<TechTile> {
  bool _isHovered = false;
  Offset? _mousePos;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDark ? AppColors.cardDark : AppColors.cardLight;
    final borderColor =
        widget.isDark ? AppColors.borderDark : AppColors.borderLight;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _mousePos = null;
      }),
      onHover: (e) => setState(() => _mousePos = e.localPosition),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -4.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? widget.iconColor.withValues(alpha: 0.4)
                : borderColor,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.iconColor.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Mouse spotlight overlay
              if (_mousePos != null && _isHovered)
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _TileSpotlightPainter(
                        position: _mousePos!,
                        color: widget.iconColor.withValues(alpha: 0.07),
                      ),
                    ),
                  ),
                ),
              // Content
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      size: 40,
                      color: widget.iconColor,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: widget.isDark
                            ? AppColors.white
                            : AppColors.dark900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TileSpotlightPainter extends CustomPainter {
  final Offset position;
  final Color color;

  _TileSpotlightPainter({required this.position, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withValues(alpha: 0)],
      ).createShader(
        Rect.fromCircle(center: position, radius: 120),
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _TileSpotlightPainter old) =>
      old.position != position;
}

