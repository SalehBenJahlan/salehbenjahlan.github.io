import 'package:flutter/material.dart';

class SkillItem {
  final String nameEn;
  final String nameAr;
  final String categoryEn;
  final String categoryAr;
  final IconData icon;
  final Color color;

  const SkillItem({
    required this.nameEn,
    required this.nameAr,
    required this.categoryEn,
    required this.categoryAr,
    required this.icon,
    required this.color,
  });

  String name(bool isArabic) => isArabic ? nameAr : nameEn;
  String category(bool isArabic) => isArabic ? categoryAr : categoryEn;
}

