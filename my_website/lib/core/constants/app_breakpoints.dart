class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 768.0;
  static const double desktop = 1200.0;

  static bool isMobile(double w) => w < mobile;
  static bool isTablet(double w) => w >= mobile && w < desktop;
  static bool isDesktop(double w) => w >= desktop;

  static int gridColumns(double w) {
    if (w >= desktop) return 4;
    if (w >= mobile) return 3;
    return 2;
  }

  static double sectionPadding(double w) {
    if (w >= desktop) return 120.0;
    if (w >= mobile) return 80.0;
    return 48.0;
  }

  static double contentMaxWidth(double w) {
    if (w >= desktop) return 1140.0;
    return w - 48;
  }
}

