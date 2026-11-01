import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'core/state/app_state.dart';
import 'widgets/cursor_spotlight.dart';
import 'widgets/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/experience_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/education_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  Offset _mousePosition = Offset.zero;
  int _activeSection = 0;
  bool _showMobileMenu = false;

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _expKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _eduKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late final List<GlobalKey> _sectionKeys = [
    _heroKey,
    _aboutKey,
    _expKey,
    _skillsKey,
    _projectsKey,
    _eduKey,
    _contactKey,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final keyContext = _sectionKeys[i].currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox?;
        if (box != null) {
          final pos = box.localToGlobal(Offset.zero);
          if (pos.dy <= 200) {
            if (_activeSection != i) {
              setState(() => _activeSection = i);
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    if (_showMobileMenu) {
      setState(() => _showMobileMenu = false);
    }

    if (index >= 0 && index < _sectionKeys.length) {
      final targetContext = _sectionKeys[index].currentContext;
      if (targetContext != null) {
        Scrollable.ensureVisible(
          targetContext,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
          alignment: 0.05,
        );
        setState(() => _activeSection = index);
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
    setState(() => _activeSection = 0);
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isDark = state.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.scaffoldDark : AppColors.scaffoldLight,
      body: MouseRegion(
        onHover: (event) =>
            setState(() => _mousePosition = event.localPosition),
        child: Stack(
          children: [
            // Global subtle ambient spotlight
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: GlobalSpotlightPainter(
                    position: _mousePosition,
                    isDark: isDark,
                  ),
                ),
              ),
            ),

            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Top spacing to account for sticky navbar
                    const SizedBox(height: 72),

                    // 1. Hero Section
                    Container(
                      key: _heroKey,
                      child: HeroSection(
                        onViewProjects: () => _scrollToSection(4),
                        onContactMe: () => _scrollToSection(6),
                      ),
                    ),

                    // 2. About Section
                    Container(
                      key: _aboutKey,
                      child: const AboutSection(),
                    ),

                    // 3. Work Experience Section (Separate from Skills!)
                    Container(
                      key: _expKey,
                      child: const ExperienceSection(),
                    ),

                    // 4. Skills & Technologies Section (Standalone section directly after Experience!)
                    Container(
                      key: _skillsKey,
                      child: const SkillsSection(),
                    ),

                    // 5. Projects Section
                    Container(
                      key: _projectsKey,
                      child: const ProjectsSection(),
                    ),

                    // 6. Education & Certificates Section
                    Container(
                      key: _eduKey,
                      child: const EducationSection(),
                    ),

                    // 7. Contact Section
                    Container(
                      key: _contactKey,
                      child: const ContactSection(),
                    ),

                    // 8. Footer Section
                    FooterSection(onScrollToTop: _scrollToTop),
                  ],
                ),
              ),
            ),

            // Sticky Navigation Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PortfolioNavBar(
                activeSection: _activeSection,
                onNavTap: _scrollToSection,
                showMobileMenu: _showMobileMenu,
                onMenuToggle: () =>
                    setState(() => _showMobileMenu = !_showMobileMenu),
              ),
            ),

            // Mobile Menu Overlay
            if (_showMobileMenu)
              Positioned.fill(
                child: MobileMenuOverlay(
                  activeSection: _activeSection,
                  onNavTap: _scrollToSection,
                  onClose: () => setState(() => _showMobileMenu = false),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
