import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_breakpoints.dart';
import '../core/state/app_state.dart';
import '../core/localization/app_localizations.dart';
import '../widgets/gradient_button.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContactMe;

  const HeroSection({
    required this.onViewProjects,
    required this.onContactMe,
    super.key,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _showDownloadCvSnackbar(BuildContext context, bool isArabic) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isArabic
              ? 'جاري تنزيل السيرة الذاتية...'
              : 'Downloading Curriculum Vitae...',
        ),
        backgroundColor: AppColors.purple,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(screenW);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 700),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient background glow effects
          Positioned(
            top: 40,
            left: screenW * 0.2,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, _) {
                  return Container(
                    width: 380 + (_pulseController.value * 40),
                    height: 380 + (_pulseController.value * 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.purple.withValues(alpha: isDark ? 0.18 : 0.08),
                          AppColors.magenta.withValues(alpha: isDark ? 0.08 : 0.03),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: screenW * 0.18,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, _) {
                  return Container(
                    width: 320 - (_pulseController.value * 30),
                    height: 320 - (_pulseController.value * 30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.cyan.withValues(alpha: isDark ? 0.15 : 0.06),
                          AppColors.blue.withValues(alpha: isDark ? 0.06 : 0.02),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Main Hero Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 48,
              vertical: isMobile ? 60 : 100,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circular Profile Avatar with glowing animated rings
                  _HeroAvatar(pulseAnim: _pulseController, isDark: isDark),
                  const SizedBox(height: 28),

                  // Role Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.cardDark.withValues(alpha: 0.8)
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppColors.purple.withValues(alpha: 0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.purple.withValues(alpha: 0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          l10n.heroRole,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.white : AppColors.dark900,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name
                  Text(
                    l10n.heroName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 32 : 44,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.white : AppColors.dark900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Premium Animated Gradient Headline
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, _) {
                      final val = _pulseController.value;
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: const [
                              AppColors.purple,
                              AppColors.magenta,
                              AppColors.cyan,
                              AppColors.orange,
                            ],
                            stops: [
                              0.0,
                              0.35 + (val * 0.15),
                              0.7 + (val * 0.15),
                              1.0,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          l10n.heroHeadline,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 34 : 54,
                            fontWeight: FontWeight.w900,
                            color: AppColors.white,
                            height: 1.15,
                            letterSpacing: -1.0,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Short supporting text
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: Text(
                      l10n.aboutDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 15 : 17,
                        height: 1.7,
                        color: isDark ? AppColors.grey300 : AppColors.dark500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 38),

                  // Three CTA Buttons: View Projects, Contact Me, Download My CV
                  Wrap(
                    spacing: 16,
                    runSpacing: 14,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      GradientButton(
                        text: l10n.heroViewProjects,
                        icon: Icons.rocket_launch_outlined,
                        style: GradientButtonStyle.filled,
                        onTap: widget.onViewProjects,
                      ),
                      GradientButton(
                        text: l10n.heroContactMe,
                        icon: Icons.mail_outline,
                        style: GradientButtonStyle.outlined,
                        onTap: widget.onContactMe,
                      ),
                      GradientButton(
                        text: l10n.heroDownloadCV,
                        icon: Icons.download_rounded,
                        style: GradientButtonStyle.ghost,
                        onTap: () => _showDownloadCvSnackbar(context, state.isArabic),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  final Animation<double> pulseAnim;
  final bool isDark;

  const _HeroAvatar({required this.pulseAnim, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseAnim,
      builder: (context, _) {
        final scale = 1.0 + (pulseAnim.value * 0.04);
        return SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer pulse glow ring
              Container(
                width: 130 * scale,
                height: 130 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.purple.withValues(alpha: 0.35),
                      AppColors.magenta.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              // Gradient border ring
              Container(
                width: 114,
                height: 114,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.purple, AppColors.cyan, AppColors.magenta],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.purple.withValues(alpha: 0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(3.5),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.scaffoldDark : AppColors.cardLight,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.purple.withValues(alpha: 0.2),
                            AppColors.cyan.withValues(alpha: 0.15),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_rounded,
                          size: 60,
                          color: isDark ? AppColors.white : AppColors.dark900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

