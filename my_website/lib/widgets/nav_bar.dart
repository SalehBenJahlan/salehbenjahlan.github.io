import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_breakpoints.dart';
import '../core/state/app_state.dart';
import '../core/localization/app_localizations.dart';

/// Sticky navigation bar with brand, nav links, language/theme toggles, and mobile menu.
class PortfolioNavBar extends StatelessWidget {
  final int activeSection;
  final ValueChanged<int> onNavTap;
  final VoidCallback onMenuToggle;
  final bool showMobileMenu;

  const PortfolioNavBar({
    required this.activeSection,
    required this.onNavTap,
    required this.onMenuToggle,
    this.showMobileMenu = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(screenW);

    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
      decoration: BoxDecoration(
        color: isDark ? AppColors.navDark : AppColors.navLight,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.borderDark.withValues(alpha: 0.5) : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Brand
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onNavTap(0),
              child: ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.heroGradient.createShader(bounds),
                child: Text(
                  l10n.brandName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),

          // Desktop nav links
          if (!isMobile) ...[
            for (int i = 0; i < l10n.navItems.length; i++) ...[
              _NavLink(
                label: l10n.navItems[i],
                isActive: activeSection == i,
                onTap: () => onNavTap(i),
                isDark: isDark,
              ),
              if (i < l10n.navItems.length - 1) const SizedBox(width: 4),
            ],
            const SizedBox(width: 16),
          ],

          // Language toggle
          _IconBtn(
            icon: Icons.translate,
            tooltip: state.isArabic ? 'English' : 'العربية',
            onTap: state.toggleLanguage,
            isDark: isDark,
          ),
          const SizedBox(width: 4),

          // Theme toggle
          _IconBtn(
            icon: isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            tooltip: isDark ? 'Light Mode' : 'Dark Mode',
            onTap: state.toggleTheme,
            isDark: isDark,
          ),

          // Mobile menu button
          if (isMobile) ...[
            const SizedBox(width: 4),
            _IconBtn(
              icon: showMobileMenu ? Icons.close : Icons.menu,
              tooltip: 'Menu',
              onTap: onMenuToggle,
              isDark: isDark,
            ),
          ],
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = widget.isActive || _isHovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isHighlighted
                ? AppColors.purple.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
              color: isHighlighted
                  ? AppColors.purple
                  : (widget.isDark ? AppColors.grey300 : AppColors.dark500),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconBtn extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isDark;

  const _IconBtn({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_IconBtn> createState() => _IconBtnState();
}

class _IconBtnState extends State<_IconBtn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.purple.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              widget.icon,
              size: 20,
              color: _isHovered
                  ? AppColors.purple
                  : (widget.isDark ? AppColors.grey300 : AppColors.dark500),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-screen mobile menu overlay.
class MobileMenuOverlay extends StatelessWidget {
  final int activeSection;
  final ValueChanged<int> onNavTap;
  final VoidCallback onClose;

  const MobileMenuOverlay({
    required this.activeSection,
    required this.onNavTap,
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;
    final l10n = AppLocalizations(isArabic: state.isArabic);

    return Container(
      color: isDark
          ? AppColors.scaffoldDark.withValues(alpha: 0.97)
          : AppColors.scaffoldLight.withValues(alpha: 0.97),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              for (int i = 0; i < l10n.navItems.length; i++)
                _MobileNavItem(
                  label: l10n.navItems[i],
                  isActive: activeSection == i,
                  onTap: () => onNavTap(i),
                  isDark: isDark,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  const _MobileNavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_MobileNavItem> createState() => _MobileNavItemState();
}

class _MobileNavItemState extends State<_MobileNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          color: widget.isActive || _isHovered
              ? AppColors.purple.withValues(alpha: 0.08)
              : Colors.transparent,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  widget.isActive ? FontWeight.w700 : FontWeight.w500,
              color: widget.isActive
                  ? AppColors.purple
                  : (widget.isDark ? AppColors.white : AppColors.dark900),
            ),
          ),
        ),
      ),
    );
  }
}

