import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// A glassmorphism-styled card with blur, transparency, and subtle border.
class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final double blur;
  final Border? border;

  const GlassCard({
    required this.child,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(24),
    this.backgroundColor,
    this.blur = 12,
    this.border,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = backgroundColor ??
        (isDark
            ? AppColors.cardDark.withValues(alpha: 0.7)
            : AppColors.cardLight.withValues(alpha: 0.8));
    final borderColor = isDark
        ? AppColors.borderDark.withValues(alpha: 0.5)
        : AppColors.borderLight.withValues(alpha: 0.5);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border ?? Border.all(color: borderColor, width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}

