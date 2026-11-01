import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_breakpoints.dart';
import '../core/state/app_state.dart';
import '../core/localization/app_localizations.dart';
import '../data/portfolio_data.dart';
import '../models/experience_item.dart';
import '../widgets/section_title.dart';
import '../widgets/cursor_spotlight.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = screenW < 1000;
    final experiences = PortfolioData.experiences;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 56 : 96,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              SectionTitle(
                normalText: l10n.expTitle,
                gradientText: l10n.expGradient,
                subtitle: l10n.expDescription,
              ),
              const SizedBox(height: 64),

              // Timeline
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                itemBuilder: (context, index) {
                  final item = experiences[index];
                  final isLast = index == experiences.length - 1;

                  if (isMobile) {
                    return _MobileTimelineItem(
                      item: item,
                      isLast: isLast,
                      isArabic: state.isArabic,
                      isDark: isDark,
                      index: index,
                    );
                  }

                  return _DesktopTimelineItem(
                    item: item,
                    isLast: isLast,
                    isArabic: state.isArabic,
                    isDark: isDark,
                    index: index,
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

/// 3-part Desktop Timeline Row:
/// Left: Content Card
/// Center: Vertical Gradient Line with Glowing Node
/// Right: Complementary Visual / Mockup Card
class _DesktopTimelineItem extends StatelessWidget {
  final ExperienceItem item;
  final bool isLast;
  final bool isArabic;
  final bool isDark;
  final int index;

  const _DesktopTimelineItem({
    required this.item,
    required this.isLast,
    required this.isArabic,
    required this.isDark,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Alternating composition on desktop adds visual dynamism
    final isEven = index % 2 == 0;
    final cardWidget = _ExperienceCard(
      item: item,
      isArabic: isArabic,
      isDark: isDark,
    );

    final visualWidget = _ComplementaryVisualCard(
      item: item,
      isArabic: isArabic,
      isDark: isDark,
      index: index,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Side (Card on even, Visual on odd)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: isEven ? cardWidget : visualWidget,
            ),
          ),

          // Center Timeline Column with Glowing Node & Line
          _TimelineCenterLine(isLast: isLast),

          // Right Side (Visual on even, Card on odd)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: isEven ? visualWidget : cardWidget,
            ),
          ),
        ],
      ),
    );
  }
}

/// Center Timeline column with gradient line & glowing pulsing node
class _TimelineCenterLine extends StatelessWidget {
  final bool isLast;

  const _TimelineCenterLine({required this.isLast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Vertical gradient line
          if (!isLast)
            Positioned(
              top: 24,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: const BoxDecoration(
                  gradient: AppColors.timelineGradient,
                ),
              ),
            ),

          // Glowing Node (inspired by Codemagic center node)
          Positioned(
            top: 24,
            child: _GlowingTimelineNode(),
          ),
        ],
      ),
    );
  }
}

class _GlowingTimelineNode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow pulse circle
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.magenta.withValues(alpha: 0.2),
            ),
          ),
          // Inner gradient node
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.magenta, AppColors.orange],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.magenta.withValues(alpha: 0.8),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          // Center dot
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

/// Experience Card:
/// - Background: #1B202A
/// - Border radius: 16px
/// - Employment status badge, Date range, Job title, Company name, Description, Tech tags
/// - Cursor spotlight & hover elevation
class _ExperienceCard extends StatefulWidget {
  final ExperienceItem item;
  final bool isArabic;
  final bool isDark;

  const _ExperienceCard({
    required this.item,
    required this.isArabic,
    required this.isDark,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
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
          radius: 200,
          color: AppColors.purple.withValues(alpha: 0.1),
          child: Container(
            padding: const EdgeInsets.all(28),
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
                      ? AppColors.purple.withValues(alpha: 0.15)
                      : Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                  blurRadius: _isHovered ? 24 : 12,
                  offset: Offset(0, _isHovered ? 8 : 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top row: Status Badge & Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.purple.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.purple.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        item.status(widget.isArabic),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.purple,
                        ),
                      ),
                    ),
                    Text(
                      item.date(widget.isArabic),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.grey500 : AppColors.dark500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Job Title
                Text(
                  item.title(widget.isArabic),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.white : AppColors.dark900,
                  ),
                ),
                const SizedBox(height: 6),

                // Company Name
                Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 16,
                      color: AppColors.cyan,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.company(widget.isArabic),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cyan,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Description
                Text(
                  item.description(widget.isArabic),
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: isDark ? AppColors.grey300 : AppColors.dark700,
                  ),
                ),
                const SizedBox(height: 20),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: item.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceDark
                            : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.grey300 : AppColors.dark700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Complementary Visual Card / Project Mockup (Inspired by Codemagic Right Side Mockup)
class _ComplementaryVisualCard extends StatelessWidget {
  final ExperienceItem item;
  final bool isArabic;
  final bool isDark;
  final int index;

  const _ComplementaryVisualCard({
    required this.item,
    required this.isArabic,
    required this.isDark,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark.withValues(alpha: 0.6) : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark.withValues(alpha: 0.6) : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Ambient radar glowing circles in the corner
            Positioned(
              right: isArabic ? null : -20,
              left: isArabic ? -20 : null,
              bottom: -20,
              child: _RadarPulseVisual(),
            ),

            // Mockup Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Window title bar dots
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5F56),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFBD2E),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFF27C93F),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '${item.company(isArabic)}.app',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.grey500 : AppColors.dark500,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Mock metric row
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.purple.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          item.icon,
                          color: AppColors.purple,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic ? 'إنجازات رئيسية' : 'Key Highlights',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.white : AppColors.dark900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isArabic
                                  ? 'تطوير وتسليم بنجاح بأعلى معايير الجودة'
                                  : 'Production deployed with 99.9% crash-free rate',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppColors.grey300 : AppColors.dark500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Architecture tags or simulated terminal block
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark.withValues(alpha: 0.7)
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      isArabic
                          ? '✓ Clean Architecture\n✓ State Management & Testing\n✓ Automated Build & Release'
                          : '✓ Clean Architecture & Scalable State\n✓ Automated CI/CD Workflows\n✓ High Test Coverage & Stability',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.6,
                        fontFamily: 'monospace',
                        color: isDark ? AppColors.teal : const Color(0xFF0D9488),
                      ),
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

/// Glowing concentric circles inspired by Codemagic screenshot
class _RadarPulseVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.magenta.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.magenta.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.magenta, AppColors.orange],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.magenta.withValues(alpha: 0.4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}

/// Single-column Mobile Timeline
class _MobileTimelineItem extends StatelessWidget {
  final ExperienceItem item;
  final bool isLast;
  final bool isArabic;
  final bool isDark;
  final int index;

  const _MobileTimelineItem({
    required this.item,
    required this.isLast,
    required this.isArabic,
    required this.isDark,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline line & node on side
          SizedBox(
            width: 36,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (!isLast)
                  Positioned(
                    top: 18,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      decoration: const BoxDecoration(
                        gradient: AppColors.timelineGradient,
                      ),
                    ),
                  ),
                Positioned(
                  top: 18,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.magenta, AppColors.orange],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.magenta.withValues(alpha: 0.6),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: _ExperienceCard(
                item: item,
                isArabic: isArabic,
                isDark: isDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

