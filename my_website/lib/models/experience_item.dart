import 'package:flutter/material.dart';

class ExperienceItem {
  final String titleEn;
  final String titleAr;
  final String companyEn;
  final String companyAr;
  final String dateEn;
  final String dateAr;
  final String descEn;
  final String descAr;
  final String statusEn;
  final String statusAr;
  final List<String> tags;
  final IconData icon;

  const ExperienceItem({
    required this.titleEn,
    required this.titleAr,
    required this.companyEn,
    required this.companyAr,
    required this.dateEn,
    required this.dateAr,
    required this.descEn,
    required this.descAr,
    required this.statusEn,
    required this.statusAr,
    required this.tags,
    required this.icon,
  });

  String title(bool isArabic) => isArabic ? titleAr : titleEn;
  String company(bool isArabic) => isArabic ? companyAr : companyEn;
  String date(bool isArabic) => isArabic ? dateAr : dateEn;
  String description(bool isArabic) => isArabic ? descAr : descEn;
  String status(bool isArabic) => isArabic ? statusAr : statusEn;
}

