import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Renders a two-part section heading: one part white, one part gradient.
/// [gradientFirst] controls whether the gradient word comes first.
class SectionTitle extends StatelessWidget {
  final String normalText;
  final String gradientText;
  final String? subtitle;
  final bool gradientFirst;

  const SectionTitle({
    required this.normalText,
    required this.gradientText,
    this.subtitle,
    this.gradientFirst = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenW = MediaQuery.of(context).size.width;
    final fontSize = screenW < 768 ? 28.0 : 40.0;
    final textColor = isDark ? AppColors.white : AppColors.dark900;

    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              height: 1.2,
              letterSpacing: -0.5,
            ),
            children: gradientFirst
                ? [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.primaryGradient.createShader(bounds),
                        child: Text(
                          gradientText,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' $normalText',
                      style: TextStyle(color: textColor),
                    ),
                  ]
                : [
                    TextSpan(
                      text: '$normalText ',
                      style: TextStyle(color: textColor),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.primaryGradient.createShader(bounds),
                        child: Text(
                          gradientText,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppColors.grey300 : AppColors.dark500,
                ),
          ),
        ],
      ],
    );
  }
}

