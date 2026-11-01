import 'package:flutter/material.dart';
import '../models/experience_item.dart';
import '../models/skill_item.dart';
import '../models/project_item.dart';
import '../models/education_item.dart';

class PortfolioData {
  PortfolioData._();

  // ─── Work Experience ───
  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      titleEn: 'Senior Flutter Developer',
      titleAr: 'مطور فلاتر أول',
      companyEn: 'TechVision',
      companyAr: 'تك فيجن',
      dateEn: 'Jan 2023 — Present',
      dateAr: 'يناير ٢٠٢٣ — الحاضر',
      descEn:
          'Leading the mobile development team in building cross-platform applications with Flutter. Implementing complex UI designs, scalable state management, and CI/CD pipelines for automated delivery.',
      descAr:
          'قيادة فريق تطوير الموبايل لبناء تطبيقات متعددة المنصات باستخدام فلاتر. تنفيذ واجهات مستخدم معقدة وإدارة حالة قابلة للتوسع وأنظمة نشر آلي.',
      statusEn: 'Full-time',
      statusAr: 'دوام كامل',
      tags: ['Flutter', 'Dart', 'Firebase', 'CI/CD'],
      icon: Icons.work_outline,
    ),
    ExperienceItem(
      titleEn: 'Mobile App Developer',
      titleAr: 'مطور تطبيقات موبايل',
      companyEn: 'AppCraft Studio',
      companyAr: 'استوديو آب كرافت',
      dateEn: 'Mar 2021 — Dec 2022',
      dateAr: 'مارس ٢٠٢١ — ديسمبر ٢٠٢٢',
      descEn:
          'Developed and maintained multiple mobile applications for clients across industries. Translated Figma designs into pixel-perfect Flutter interfaces with smooth animations.',
      descAr:
          'تطوير وصيانة تطبيقات موبايل متعددة للعملاء في مختلف الصناعات. تحويل تصاميم فيجما إلى واجهات فلاتر دقيقة مع حركات انسيابية.',
      statusEn: 'Full-time',
      statusAr: 'دوام كامل',
      tags: ['Flutter', 'Dart', 'REST APIs', 'Figma'],
      icon: Icons.phone_android,
    ),
    ExperienceItem(
      titleEn: 'Junior Developer',
      titleAr: 'مطور مبتدئ',
      companyEn: 'Digital Solutions',
      companyAr: 'الحلول الرقمية',
      dateEn: 'Jun 2020 — Feb 2021',
      dateAr: 'يونيو ٢٠٢٠ — فبراير ٢٠٢١',
      descEn:
          'Built Android applications using Kotlin and Java. Gained foundational experience in mobile development, version control with Git, and agile methodologies.',
      descAr:
          'بناء تطبيقات أندرويد باستخدام كوتلن وجافا. اكتساب خبرة أساسية في تطوير الموبايل وإدارة الإصدارات ومنهجيات أجايل.',
      statusEn: 'Contract',
      statusAr: 'عقد',
      tags: ['Android', 'Kotlin', 'Git', 'REST APIs'],
      icon: Icons.code,
    ),
  ];

  // ─── Skills & Technologies ───
  static const List<SkillItem> skills = [
    SkillItem(
      nameEn: 'Flutter',
      nameAr: 'فلاتر',
      categoryEn: 'Mobile Development',
      categoryAr: 'تطوير الموبايل',
      icon: Icons.flutter_dash,
      color: Color(0xFF02569B),
    ),
    SkillItem(
      nameEn: 'Dart',
      nameAr: 'دارت',
      categoryEn: 'Mobile Development',
      categoryAr: 'تطوير الموبايل',
      icon: Icons.code,
      color: Color(0xFF0175C2),
    ),
    SkillItem(
      nameEn: 'Firebase',
      nameAr: 'فايربيس',
      categoryEn: 'Backend & APIs',
      categoryAr: 'الخوادم والواجهات البرمجية',
      icon: Icons.local_fire_department,
      color: Color(0xFFFFCA28),
    ),
    SkillItem(
      nameEn: 'REST APIs',
      nameAr: 'واجهات REST',
      categoryEn: 'Backend & APIs',
      categoryAr: 'الخوادم والواجهات البرمجية',
      icon: Icons.api,
      color: Color(0xFF4CAF50),
    ),
    SkillItem(
      nameEn: 'Git',
      nameAr: 'جت',
      categoryEn: 'Workflow & Deployment',
      categoryAr: 'سير العمل والنشر',
      icon: Icons.account_tree,
      color: Color(0xFFF05032),
    ),
    SkillItem(
      nameEn: 'GitHub',
      nameAr: 'جت هب',
      categoryEn: 'Workflow & Deployment',
      categoryAr: 'سير العمل والنشر',
      icon: Icons.hub,
      color: Color(0xFFE6EDF3),
    ),
    SkillItem(
      nameEn: 'Figma',
      nameAr: 'فيجما',
      categoryEn: 'Design Tools',
      categoryAr: 'أدوات التصميم',
      icon: Icons.design_services,
      color: Color(0xFFA259FF),
    ),
    SkillItem(
      nameEn: 'Android',
      nameAr: 'أندرويد',
      categoryEn: 'Mobile Development',
      categoryAr: 'تطوير الموبايل',
      icon: Icons.android,
      color: Color(0xFF3DDC84),
    ),
    SkillItem(
      nameEn: 'iOS',
      nameAr: 'آي أو إس',
      categoryEn: 'Mobile Development',
      categoryAr: 'تطوير الموبايل',
      icon: Icons.phone_iphone,
      color: Color(0xFFADB5C7),
    ),
    SkillItem(
      nameEn: 'VS Code',
      nameAr: 'في إس كود',
      categoryEn: 'Design Tools',
      categoryAr: 'أدوات التصميم',
      icon: Icons.terminal,
      color: Color(0xFF007ACC),
    ),
    SkillItem(
      nameEn: 'CI/CD',
      nameAr: 'النشر المستمر',
      categoryEn: 'Workflow & Deployment',
      categoryAr: 'سير العمل والنشر',
      icon: Icons.sync,
      color: Color(0xFF00BCD4),
    ),
  ];

  // ─── Projects ───
  static const List<ProjectItem> projects = [
    ProjectItem(
      titleEn: 'ShopEase',
      titleAr: 'شوب إيز',
      descEn:
          'Full-featured e-commerce app with product catalog, shopping cart, secure payments, and real-time order tracking.',
      descAr:
          'تطبيق تجارة إلكترونية متكامل مع كتالوج منتجات وسلة مشتريات ودفع آمن وتتبع الطلبات.',
      category: 'Mobile',
      tags: ['Flutter', 'Dart', 'Firebase', 'REST APIs'],
      icon: Icons.shopping_bag_outlined,
      accentColor: Color(0xFFB44AFF),
    ),
    ProjectItem(
      titleEn: 'TaskFlow',
      titleAr: 'تاسك فلو',
      descEn:
          'Productivity app with drag-and-drop task boards, team collaboration, and real-time sync across devices.',
      descAr:
          'تطبيق إنتاجية مع لوحات مهام قابلة للسحب وميزات التعاون والمزامنة الفورية.',
      category: 'Mobile',
      tags: ['Flutter', 'Dart', 'Firebase'],
      icon: Icons.task_alt,
      accentColor: Color(0xFF00D4FF),
    ),
    ProjectItem(
      titleEn: 'FoodHub',
      titleAr: 'فود هب',
      descEn:
          'Restaurant discovery and booking app with real-time availability, reviews, and personalized recommendations.',
      descAr:
          'تطبيق اكتشاف المطاعم والحجز مع التوفر الفوري والتقييمات والتوصيات المخصصة.',
      category: 'UI/UX',
      tags: ['Flutter', 'Figma', 'REST APIs'],
      icon: Icons.restaurant_outlined,
      accentColor: Color(0xFFFF6AC1),
    ),
    ProjectItem(
      titleEn: 'WeatherView',
      titleAr: 'ويذر فيو',
      descEn:
          'Real-time weather dashboard with interactive forecasts, location-based data, and beautiful animated visualizations.',
      descAr:
          'لوحة طقس فورية مع توقعات تفاعلية وبيانات حسب الموقع ورسوم متحركة جميلة.',
      category: 'Web',
      tags: ['Flutter', 'Dart', 'REST APIs'],
      icon: Icons.cloud_outlined,
      accentColor: Color(0xFF4A7AFF),
    ),
    ProjectItem(
      titleEn: 'PortfolioSite',
      titleAr: 'موقع البورتفوليو',
      descEn:
          'Personal portfolio website built with Flutter Web featuring bilingual support, responsive design, and premium animations.',
      descAr:
          'موقع بورتفوليو شخصي مبني بفلاتر ويب مع دعم ثنائي اللغة وتصميم متجاوب وحركات متميزة.',
      category: 'Web',
      tags: ['Flutter', 'Dart', 'CI/CD'],
      icon: Icons.language,
      accentColor: Color(0xFF34D399),
    ),
  ];

  // ─── Education & Certificates ───
  static const List<EducationItem> education = [
    EducationItem(
      titleEn: 'BSc in Computer Science',
      titleAr: 'بكالوريوس علوم الحاسب',
      institutionEn: 'King Abdulaziz University',
      institutionAr: 'جامعة الملك عبدالعزيز',
      periodEn: '2016 — 2020',
      periodAr: '٢٠١٦ — ٢٠٢٠',
      icon: Icons.school,
    ),
    EducationItem(
      titleEn: 'Flutter & Dart Bootcamp',
      titleAr: 'معسكر فلاتر ودارت',
      institutionEn: 'Udemy',
      institutionAr: 'يوديمي',
      periodEn: '2021',
      periodAr: '٢٠٢١',
      icon: Icons.workspace_premium,
    ),
    EducationItem(
      titleEn: 'Google UX Design Certificate',
      titleAr: 'شهادة تصميم UX من جوجل',
      institutionEn: 'Google / Coursera',
      institutionAr: 'جوجل / كورسيرا',
      periodEn: '2022',
      periodAr: '٢٠٢٢',
      icon: Icons.verified,
    ),
  ];
}

