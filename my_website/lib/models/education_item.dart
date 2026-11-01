import 'package:flutter/material.dart';

class EducationItem {
  final String titleEn;
  final String titleAr;
  final String institutionEn;
  final String institutionAr;
  final String periodEn;
  final String periodAr;
  final IconData icon;
  final bool isCompleted;

  const EducationItem({
    required this.titleEn,
    required this.titleAr,
    required this.institutionEn,
    required this.institutionAr,
    required this.periodEn,
    required this.periodAr,
    required this.icon,
    this.isCompleted = true,
  });

  String title(bool isArabic) => isArabic ? titleAr : titleEn;
  String institution(bool isArabic) => isArabic ? institutionAr : institutionEn;
  String period(bool isArabic) => isArabic ? periodAr : periodEn;
}

