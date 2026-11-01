import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_breakpoints.dart';
import '../core/state/app_state.dart';
import '../core/localization/app_localizations.dart';
import '../widgets/section_title.dart';
import '../widgets/animated_counter.dart';
import '../widgets/glass_card.dart';
import '../widgets/cursor_spotlight.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(screenW);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 48 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              SectionTitle(
                normalText: l10n.aboutTitle,
                gradientText: l10n.aboutGradient,
                subtitle: l10n.aboutDescription,
              ),
              const SizedBox(height: 56),

              // Animated Statistics Container
              CursorSpotlight(
                borderRadius: BorderRadius.circular(20),
                radius: 220,
                color: AppColors.purple.withValues(alpha: 0.1),
                child: GlassCard(
                  borderRadius: 20,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 48,
                    vertical: isMobile ? 32 : 44,
                  ),
                  backgroundColor: isDark
                      ? AppColors.cardDark.withValues(alpha: 0.85)
                      : AppColors.cardLight.withValues(alpha: 0.9),
                  child: isMobile
                      ? Column(
                          children: [
                            AnimatedCounter(
                              targetValue: 4,
                              suffix: '+',
                              label: l10n.aboutYearsExp,
                            ),
                            const _StatDivider(isVertical: false),
                            AnimatedCounter(
                              targetValue: 25,
                              suffix: '+',
                              label: l10n.aboutProjects,
                            ),
                            const _StatDivider(isVertical: false),
                            AnimatedCounter(
                              targetValue: 15,
                              suffix: '+',
                              label: l10n.aboutTechnologies,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: AnimatedCounter(
                                targetValue: 4,
                                suffix: '+',
                                label: l10n.aboutYearsExp,
                              ),
                            ),
                            const _StatDivider(isVertical: true),
                            Expanded(
                              child: AnimatedCounter(
                                targetValue: 25,
                                suffix: '+',
                                label: l10n.aboutProjects,
                              ),
                            ),
                            const _StatDivider(isVertical: true),
                            Expanded(
                              child: AnimatedCounter(
                                targetValue: 15,
                                suffix: '+',
                                label: l10n.aboutTechnologies,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 48),

              // Highlight Pillars
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _FeaturePill(
                    icon: Icons.speed_rounded,
                    title: state.isArabic ? 'أداء عالي' : 'High Performance',
                    description: state.isArabic
                        ? 'تطبيقات سريعة ومحسّنة لأعلى استجابة وسلاسة 60fps'
                        : '60fps butter-smooth rendering & optimized architecture',
                    isDark: isDark,
                  ),
                  _FeaturePill(
                    icon: Icons.palette_outlined,
                    title: state.isArabic ? 'تصميم متقن' : 'Pixel-Perfect UI',
                    description: state.isArabic
                        ? 'واجهات عصرية بتفاصيل متقنة ورسوم متحركة مدروسة'
                        : 'Modern interfaces with eye for detail and micro-interactions',
                    isDark: isDark,
                  ),
                  _FeaturePill(
                    icon: Icons.devices_outlined,
                    title: state.isArabic ? 'متعدد المنصات' : 'Cross Platform',
                    description: state.isArabic
                        ? 'كود واحد يعمل بكفاءة على iOS و Android والويب'
                        : 'Single codebase powering iOS, Android, and responsive Web',
                    isDark: isDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  final bool isVertical;

  const _StatDivider({required this.isVertical});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppColors.borderDark : AppColors.borderLight;

    return isVertical
        ? Container(
            width: 1,
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            color: color,
          )
        : Container(
            height: 1,
            width: 120,
            margin: const EdgeInsets.symmetric(vertical: 24),
            color: color,
          );
  }
}

class _FeaturePill extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isDark;

  const _FeaturePill({
    required this.icon,
    required this.title,
    required this.description,
    required this.isDark,
  });

  @override
  State<_FeaturePill> createState() => _FeaturePillState();
}

class _FeaturePillState extends State<_FeaturePill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 320,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppColors.purple.withValues(alpha: 0.5)
                : (widget.isDark ? AppColors.borderDark : AppColors.borderLight),
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.purple.withValues(alpha: 0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -3.0))
            : Matrix4.identity(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.icon, color: AppColors.purple, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: widget.isDark ? AppColors.white : AppColors.dark900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: widget.isDark ? AppColors.grey300 : AppColors.dark500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

