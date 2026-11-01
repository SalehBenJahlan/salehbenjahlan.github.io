import 'package:flutter/material.dart';

class ProjectItem {
  final String titleEn;
  final String titleAr;
  final String descEn;
  final String descAr;
  final String category; // 'Mobile', 'Web', 'UI/UX'
  final List<String> tags;
  final IconData icon;
  final Color accentColor;

  const ProjectItem({
    required this.titleEn,
    required this.titleAr,
    required this.descEn,
    required this.descAr,
    required this.category,
    required this.tags,
    required this.icon,
    required this.accentColor,
  });

  String title(bool isArabic) => isArabic ? titleAr : titleEn;
  String description(bool isArabic) => isArabic ? descAr : descEn;
}

