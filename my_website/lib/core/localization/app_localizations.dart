/// All user-facing strings in English and Arabic.
class AppLocalizations {
  final bool isArabic;
  const AppLocalizations({this.isArabic = false});

  String get locale => isArabic ? 'ar' : 'en';

  // ─── Navigation ───
  List<String> get navItems => isArabic
      ? const ['الرئيسية', 'عني', 'الخبرة', 'المهارات', 'المشاريع', 'التعليم', 'التواصل']
      : const ['Home', 'About', 'Experience', 'Skills', 'Projects', 'Education', 'Contact'];

  String get brandName => isArabic ? 'صالح' : 'Saleh';

  // ─── Hero ───
  String get heroName => isArabic ? 'صالح بن جهلان' : 'Saleh Ben Jahlan';
  String get heroRole =>
      isArabic ? 'مطور فلاتر ومصمم واجهات المستخدم' : 'Flutter Developer & UI/UX Designer';
  String get heroHeadline =>
      isArabic ? 'بناء تجارب رقمية مدروسة' : 'Building Thoughtful Digital Experiences';
  String get heroViewProjects => isArabic ? 'عرض المشاريع' : 'View Projects';
  String get heroContactMe => isArabic ? 'تواصل معي' : 'Contact Me';
  String get heroDownloadCV => isArabic ? 'تحميل السيرة الذاتية' : 'Download My CV';

  // ─── About ───
  String get aboutTitle => isArabic ? 'نبذة' : 'About';
  String get aboutGradient => isArabic ? 'عني' : 'Me';
  String get aboutDescription => isArabic
      ? 'مطور تطبيقات موبايل متخصص في فلاتر مع شغف بتصميم واجهات مستخدم جميلة وفعالة. أسعى لبناء تطبيقات عالية الجودة تجمع بين الأداء المتميز والتصميم الأنيق لتقديم أفضل تجربة للمستخدم.'
      : 'A passionate mobile developer specializing in Flutter with a keen eye for beautiful, functional UI design. I build high-quality applications that combine excellent performance with elegant design to deliver the best user experience.';
  String get aboutYearsExp => isArabic ? 'سنوات الخبرة' : 'Years Experience';
  String get aboutProjects => isArabic ? 'مشاريع منجزة' : 'Projects Done';
  String get aboutTechnologies => isArabic ? 'تقنيات مستخدمة' : 'Technologies';

  // ─── Experience ───
  String get expTitle => isArabic ? 'الخبرة' : 'Work';
  String get expGradient => isArabic ? 'العملية' : 'Experience';
  String get expDescription => isArabic
      ? 'رحلتي المهنية في تطوير البرمجيات وبناء المنتجات الرقمية'
      : 'My professional journey in software development and building digital products';

  // ─── Skills ───
  String get skillsTitle => isArabic ? 'المهارات و' : 'Skills &';
  String get skillsGradient => isArabic ? 'التقنيات' : 'Technologies';
  String get skillsDescription => isArabic
      ? 'الأدوات والتقنيات التي أستخدمها لبناء تجارب رقمية متميزة'
      : 'Tools and technologies I use to craft outstanding digital experiences';

  // ─── Projects ───
  String get projectsTitle => isArabic ? 'أعمالي' : 'My';
  String get projectsGradient => isArabic ? 'ومشاريعي' : 'Projects';
  String get projectsDescription => isArabic
      ? 'مجموعة مختارة من المشاريع التي عملت عليها'
      : 'A curated collection of projects I have worked on';
  String get filterAll => isArabic ? 'الكل' : 'All';
  String get filterMobile => isArabic ? 'موبايل' : 'Mobile';
  String get filterWeb => isArabic ? 'ويب' : 'Web';
  String get filterUiUx => isArabic ? 'تصميم' : 'UI/UX';
  String get viewCode => isArabic ? 'الكود' : 'Code';
  String get liveDemo => isArabic ? 'معاينة' : 'Demo';

  // ─── Education ───
  String get eduTitle => isArabic ? 'التعليم و' : 'Education &';
  String get eduGradient => isArabic ? 'الشهادات' : 'Certificates';
  String get eduDescription => isArabic
      ? 'مسيرتي الأكاديمية والشهادات المهنية'
      : 'My academic background and professional certifications';

  // ─── Contact ───
  String get contactTitle => isArabic ? 'تواصل' : 'Get in';
  String get contactGradient => isArabic ? 'معي' : 'Touch';
  String get contactDescription => isArabic
      ? 'أنا متاح دائماً للمشاريع الجديدة والفرص المثيرة. لا تتردد في التواصل!'
      : 'I am always open to new projects and exciting opportunities. Feel free to reach out!';
  String get contactEmail => 'saleh@example.com';
  String get contactPhone => '+966 50 123 4567';
  String get contactLocation =>
      isArabic ? 'الرياض، السعودية' : 'Riyadh, Saudi Arabia';
  String get contactSendMessage => isArabic ? 'أرسل رسالة' : 'Send Message';
  String get contactLetsTalk => isArabic ? 'دعنا نتحدث' : "Let's Talk";

  // ─── Footer ───
  String get footerRights => isArabic ? 'جميع الحقوق محفوظة' : 'All rights reserved';
  String get footerAvailable =>
      isArabic ? 'متاح للعمل الحر' : 'Available for freelance';
  String get footerBuiltWith => isArabic ? 'صُنع بـ Flutter' : 'Built with Flutter';

  // ─── Common Labels ───
  String get currentLabel => isArabic ? 'حالي' : 'Current';
  String get completedLabel => isArabic ? 'مكتمل' : 'Completed';
}

