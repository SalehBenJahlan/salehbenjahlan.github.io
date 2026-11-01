import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_breakpoints.dart';
import '../core/state/app_state.dart';
import '../core/localization/app_localizations.dart';
import '../data/portfolio_data.dart';
import '../models/project_item.dart';
import '../widgets/section_title.dart';
import '../widgets/glass_card.dart';
import '../widgets/cursor_spotlight.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _activeFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(screenW);
    final isDesktop = AppBreakpoints.isDesktop(screenW);

    final filters = ['All', 'Mobile', 'Web', 'UI/UX'];
    final allProjects = PortfolioData.projects;
    final filtered = _activeFilter == 'All'
        ? allProjects
        : allProjects.where((p) => p.category == _activeFilter).toList();

    final columns = isDesktop ? 3 : (screenW >= 700 ? 2 : 1);

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
                normalText: l10n.projectsTitle,
                gradientText: l10n.projectsGradient,
                subtitle: l10n.projectsDescription,
              ),
              const SizedBox(height: 36),

              // Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: filters.map((f) {
                    final isSelected = _activeFilter == f;
                    final label = _filterLabel(f, l10n);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text(label),
                        selected: isSelected,
                        onSelected: (val) {
                          if (val) setState(() => _activeFilter = f);
                        },
                        selectedColor: AppColors.purple.withValues(alpha: 0.2),
                        backgroundColor: isDark
                            ? AppColors.cardDark
                            : AppColors.surfaceLight,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? AppColors.purple
                              : (isDark ? AppColors.grey300 : AppColors.dark700),
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: 13,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.purple
                              : (isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 48),

              // Responsive Project Cards Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final spacing = 24.0;
                  final totalSpacing = spacing * (columns - 1);
                  final cardWidth =
                      (constraints.maxWidth - totalSpacing) / columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: filtered.map((project) {
                      return SizedBox(
                        width: cardWidth,
                        child: _ProjectCard(
                          project: project,
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

  String _filterLabel(String filter, AppLocalizations l10n) {
    switch (filter) {
      case 'All':
        return l10n.filterAll;
      case 'Mobile':
        return l10n.filterMobile;
      case 'Web':
        return l10n.filterWeb;
      case 'UI/UX':
        return l10n.filterUiUx;
      default:
        return filter;
    }
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  final bool isArabic;
  final bool isDark;
  final AppLocalizations l10n;

  const _ProjectCard({
    required this.project,
    required this.isArabic,
    required this.isDark,
    required this.l10n,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  void _showActionFeedback(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action: ${widget.project.title(widget.isArabic)}'),
        backgroundColor: widget.project.accentColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final isDark = widget.isDark;
    final bgColor = isDark ? AppColors.cardDark : AppColors.cardLight;
    final borderColor =
        isDark ? AppColors.borderDark : AppColors.borderLight;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -4.0))
            : Matrix4.identity(),
        child: CursorSpotlight(
          borderRadius: BorderRadius.circular(16),
          radius: 200,
          color: p.accentColor.withValues(alpha: 0.12),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? p.accentColor.withValues(alpha: 0.5)
                    : borderColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? p.accentColor.withValues(alpha: 0.18)
                      : Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                  blurRadius: _isHovered ? 24 : 10,
                  offset: Offset(0, _isHovered ? 8 : 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mockup Visual Header
                  Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          p.accentColor.withValues(alpha: isDark ? 0.25 : 0.15),
                          isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Category Badge
                        Positioned(
                          top: 14,
                          right: widget.isArabic ? null : 14,
                          left: widget.isArabic ? 14 : null,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.black.withValues(alpha: 0.5)
                                  : Colors.white.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              p.category,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: p.accentColor,
                              ),
                            ),
                          ),
                        ),
                        // Central Mockup Icon Graphic
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: p.accentColor.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: p.accentColor.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            p.icon,
                            color: p.accentColor,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Card Body
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.title(widget.isArabic),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.white : AppColors.dark900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p.description(widget.isArabic),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: isDark ? AppColors.grey300 : AppColors.dark500,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Tech Tags
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: p.tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.surfaceDark
                                    : AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppColors.grey300
                                      : AppColors.dark700,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        // Action Buttons: Demo & Code (>=44px interactive height)
                        Row(
                          children: [
                            Expanded(
                              child: _CardButton(
                                text: widget.l10n.liveDemo,
                                icon: Icons.open_in_new_rounded,
                                isPrimary: true,
                                color: p.accentColor,
                                onTap: () => _showActionFeedback(
                                  context,
                                  widget.l10n.liveDemo,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _CardButton(
                                text: widget.l10n.viewCode,
                                icon: Icons.code_rounded,
                                isPrimary: false,
                                color: isDark
                                    ? AppColors.grey300
                                    : AppColors.dark700,
                                isDark: isDark,
                                onTap: () => _showActionFeedback(
                                  context,
                                  widget.l10n.viewCode,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isPrimary;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _CardButton({
    required this.text,
    required this.icon,
    required this.isPrimary,
    required this.color,
    this.isDark = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 44, // Minimum 44px target height
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isPrimary
                ? color.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isPrimary
                  ? color.withValues(alpha: 0.4)
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

