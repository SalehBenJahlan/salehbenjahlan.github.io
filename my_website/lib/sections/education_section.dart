import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_breakpoints.dart';
import '../core/state/app_state.dart';
import '../core/localization/app_localizations.dart';
import '../data/portfolio_data.dart';
import '../models/education_item.dart';
import '../widgets/section_title.dart';
import '../widgets/cursor_spotlight.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(screenW);
    final isDesktop = AppBreakpoints.isDesktop(screenW);
    final items = PortfolioData.education;

    final columns = isDesktop ? 3 : (screenW >= 720 ? 2 : 1);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 56 : 96,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              SectionTitle(
                normalText: l10n.eduTitle,
                gradientText: l10n.eduGradient,
                subtitle: l10n.eduDescription,
              ),
              const SizedBox(height: 56),

              LayoutBuilder(
                builder: (context, constraints) {
                  final spacing = 20.0;
                  final totalSpacing = spacing * (columns - 1);
                  final itemWidth =
                      (constraints.maxWidth - totalSpacing) / columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: items.map((item) {
                      return SizedBox(
                        width: itemWidth,
                        child: _EducationCard(
                          item: item,
                          isArabic: state.isArabic,
                          isDark: isDark,
                          l10n: l10n,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EducationCard extends StatefulWidget {
  final EducationItem item;
  final bool isArabic;
  final bool isDark;
  final AppLocalizations l10n;

  const _EducationCard({
    required this.item,
    required this.isArabic,
    required this.isDark,
    required this.l10n,
  });

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final isDark = widget.isDark;
    final bgColor = isDark ? AppColors.cardDark : AppColors.cardLight;
    final borderColor =
        isDark ? AppColors.borderDark : AppColors.borderLight;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -4.0))
            : Matrix4.identity(),
        child: CursorSpotlight(
          borderRadius: BorderRadius.circular(16),
          radius: 180,
          color: AppColors.purple.withValues(alpha: 0.1),
          child: Container(
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? AppColors.purple.withValues(alpha: 0.5)
                    : borderColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? AppColors.purple.withValues(alpha: 0.12)
                      : Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: _isHovered ? 20 : 8,
                  offset: Offset(0, _isHovered ? 6 : 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon and Verified Status badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.purple.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item.icon,
                        color: AppColors.purple,
                        size: 26,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.green.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.green,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.l10n.completedLabel,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Degree / Title
                Text(
                  item.title(widget.isArabic),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.white : AppColors.dark900,
                  ),
                ),
                const SizedBox(height: 6),

                // Institution
                Text(
                  item.institution(widget.isArabic),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.grey300 : AppColors.dark500,
                  ),
                ),
                const SizedBox(height: 14),

                // Period
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: isDark ? AppColors.grey500 : AppColors.dark500,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.period(widget.isArabic),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.grey500 : AppColors.dark500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

