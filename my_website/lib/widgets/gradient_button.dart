import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

enum GradientButtonStyle { filled, outlined, ghost }

/// A premium CTA button with gradient fill, outline, or ghost styles.
class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final GradientButtonStyle style;
  final IconData? icon;
  final double height;

  const GradientButton({
    required this.text,
    this.onTap,
    this.style = GradientButtonStyle.filled,
    this.icon,
    this.height = 48,
    super.key,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (widget.style) {
      case GradientButtonStyle.filled:
        return _buildFilled(isDark);
      case GradientButtonStyle.outlined:
        return _buildOutlined(isDark);
      case GradientButtonStyle.ghost:
        return _buildGhost(isDark);
    }
  }

  Widget _buildFilled(bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.purple, AppColors.magenta],
            ),
            borderRadius: BorderRadius.circular(widget.height / 2),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.purple.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.purple.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0.0, -2.0))
              : Matrix4.identity(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: AppColors.white, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlined(bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.purple.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(widget.height / 2),
            border: Border.all(
              color: _isHovered ? AppColors.purple : (isDark ? AppColors.borderDark : AppColors.borderLight),
              width: 1.5,
            ),
          ),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0.0, -2.0))
              : Matrix4.identity(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: isDark ? AppColors.white : AppColors.dark900,
                  size: 18,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  color: isDark ? AppColors.white : AppColors.dark900,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGhost(bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            color: _isHovered
                ? (isDark
                    ? AppColors.white.withValues(alpha: 0.06)
                    : AppColors.dark900.withValues(alpha: 0.06))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(widget.height / 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: _isHovered
                      ? AppColors.purple
                      : (isDark ? AppColors.grey300 : AppColors.dark500),
                  size: 18,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  color: _isHovered
                      ? AppColors.purple
                      : (isDark ? AppColors.grey300 : AppColors.dark500),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

