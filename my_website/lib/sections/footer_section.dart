import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_breakpoints.dart';
import '../core/state/app_state.dart';
import '../core/localization/app_localizations.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onScrollToTop;

  const FooterSection({required this.onScrollToTop, super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(screenW);
    final year = DateTime.now().year;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: 36,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.scaffoldDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark
                ? AppColors.borderDark.withValues(alpha: 0.6)
                : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _BrandAndStatus(l10n: l10n, isDark: isDark),
                    const SizedBox(height: 18),
                    _Copyright(year: year, l10n: l10n, isDark: isDark),
                    const SizedBox(height: 18),
                    _BackToTop(onTap: onScrollToTop, isDark: isDark),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _BrandAndStatus(l10n: l10n, isDark: isDark),
                    _Copyright(year: year, l10n: l10n, isDark: isDark),
                    _BackToTop(onTap: onScrollToTop, isDark: isDark),
                  ],
                ),
        ),
      ),
    );
  }
}

class _BrandAndStatus extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isDark;

  const _BrandAndStatus({required this.l10n, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.heroGradient.createShader(bounds),
          child: Text(
            l10n.brandName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                l10n.footerAvailable,
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
    );
  }
}

class _Copyright extends StatelessWidget {
  final int year;
  final AppLocalizations l10n;
  final bool isDark;

  const _Copyright({
    required this.year,
    required this.l10n,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '© $year ${l10n.heroName}. ${l10n.footerRights}.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        color: isDark ? AppColors.grey500 : AppColors.dark500,
      ),
    );
  }
}

class _BackToTop extends StatefulWidget {
  final VoidCallback onTap;
  final bool isDark;

  const _BackToTop({required this.onTap, required this.isDark});

  @override
  State<_BackToTop> createState() => _BackToTopState();
}

class _BackToTopState extends State<_BackToTop> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.purple.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered
                  ? AppColors.purple
                  : (widget.isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight),
              width: 1,
            ),
          ),
          child: Icon(
            Icons.keyboard_arrow_up_rounded,
            size: 24,
            color: _hovered
                ? AppColors.purple
                : (widget.isDark ? AppColors.grey300 : AppColors.dark500),
          ),
        ),
      ),
    );
  }
}

