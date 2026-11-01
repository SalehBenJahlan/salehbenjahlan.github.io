import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_breakpoints.dart';
import '../core/state/app_state.dart';
import '../core/localization/app_localizations.dart';
import '../data/portfolio_data.dart';
import '../models/skill_item.dart';
import '../widgets/tech_tile.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(screenW);
    final isTablet = AppBreakpoints.isTablet(screenW);

    final columns = isMobile ? 2 : (isTablet ? 3 : 4);

    final allSkills = PortfolioData.skills;
    final categories = [
      'All',
      'Mobile Development',
      'Backend & APIs',
      'Design Tools',
      'Workflow & Deployment',
    ];

    final filteredSkills = _selectedCategory == 'All'
        ? allSkills
        : allSkills.where((s) => s.categoryEn == _selectedCategory).toList();

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
              // Title: "Skills & Technologies" with ShaderMask Linear Gradient ONLY on "Technologies"
              _buildTitle(context, l10n, isDark, screenW),
              const SizedBox(height: 16),

              // Short supporting description
              Text(
                l10n.skillsDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 15 : 17,
                  color: isDark ? AppColors.grey300 : AppColors.dark500,
                ),
              ),
              const SizedBox(height: 36),

              // Optional Category Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    final catLabel = _getCategoryLabel(cat, state.isArabic);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ChoiceChip(
                        label: Text(catLabel),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedCategory = cat);
                          }
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
              const SizedBox(height: 40),

              // Large Full-Width Skills Panel with Purple/Cyan Radial Glows
              _buildSkillsPanel(
                context: context,
                isDark: isDark,
                isMobile: isMobile,
                columns: columns,
                skills: filteredSkills,
                isArabic: state.isArabic,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Title with Linear Gradient applied ONLY to "Technologies" using ShaderMask
  Widget _buildTitle(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
    double screenW,
  ) {
    final fontSize = screenW < 768 ? 28.0 : 42.0;
    final whiteTextColor = isDark ? AppColors.white : AppColors.dark900;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
        ),
        children: [
          TextSpan(
            text: '${l10n.skillsTitle} ',
            style: TextStyle(color: whiteTextColor),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.cyan, AppColors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                l10n.skillsGradient,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Large full-width Skills panel:
  /// - Dark translucent background
  /// - 20px border radius
  /// - Soft purple radial glow on the left
  /// - Soft cyan radial glow on the right
  /// - Generous internal spacing
  Widget _buildSkillsPanel({
    required BuildContext context,
    required bool isDark,
    required bool isMobile,
    required int columns,
    required List<SkillItem> skills,
    required bool isArabic,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF131722).withValues(alpha: 0.85)
            : AppColors.surfaceLight.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? AppColors.borderDark.withValues(alpha: 0.7)
              : AppColors.borderLight,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Soft purple radial glow on the left
            Positioned(
              left: -80,
              top: 60,
              child: IgnorePointer(
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.purple.withValues(alpha: isDark ? 0.20 : 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Soft cyan radial glow on the right
            Positioned(
              right: -80,
              bottom: 60,
              child: IgnorePointer(
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.cyan.withValues(alpha: isDark ? 0.18 : 0.06),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Generous internal spacing & Grid
            Padding(
              padding: EdgeInsets.all(isMobile ? 20 : 44),
              child: _buildGrid(skills, columns, isDark, isArabic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(
    List<SkillItem> skills,
    int columns,
    bool isDark,
    bool isArabic,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = 16.0;
        final totalSpacing = spacing * (columns - 1);
        final itemWidth = (constraints.maxWidth - totalSpacing) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: skills.map((skill) {
            return SizedBox(
              width: itemWidth,
              child: TechTile(
                icon: skill.icon,
                name: skill.name(isArabic),
                iconColor: skill.color,
                isDark: isDark,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String _getCategoryLabel(String category, bool isArabic) {
    if (!isArabic) return category;
    switch (category) {
      case 'All':
        return 'الكل';
      case 'Mobile Development':
        return 'تطوير الموبايل';
      case 'Backend & APIs':
        return 'الخوادم والواجهات البرمجية';
      case 'Design Tools':
        return 'أدوات التصميم';
      case 'Workflow & Deployment':
        return 'سير العمل والنشر';
      default:
        return category;
    }
  }
}

