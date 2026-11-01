import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Dark Theme Surfaces ───
  static const Color scaffoldDark = Color(0xFF0F1117);
  static const Color cardDark = Color(0xFF1B202A);
  static const Color surfaceDark = Color(0xFF161B22);
  static const Color navDark = Color(0xDD0F1117);
  static const Color borderDark = Color(0xFF2A2F3A);

  // ─── Light Theme Surfaces ───
  static const Color scaffoldLight = Color(0xFFF8FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF1F5F9);
  static const Color navLight = Color(0xDDF8FAFC);
  static const Color borderLight = Color(0xFFE2E8F0);

  // ─── Gradient Spectrum ───
  static const Color purple = Color(0xFFB44AFF);
  static const Color magenta = Color(0xFFFF6AC1);
  static const Color cyan = Color(0xFF00D4FF);
  static const Color blue = Color(0xFF4A7AFF);
  static const Color orange = Color(0xFFFF8A4A);
  static const Color pink = Color(0xFFFF4A8D);
  static const Color teal = Color(0xFF2DD4BF);

  // ─── Text Palette ───
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey300 = Color(0xFFADB5C7);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey700 = Color(0xFF374151);
  static const Color dark900 = Color(0xFF1E293B);
  static const Color dark700 = Color(0xFF334155);
  static const Color dark500 = Color(0xFF64748B);

  // ─── Status ───
  static const Color green = Color(0xFF34D399);
  static const Color red = Color(0xFFEF4444);
  static const Color yellow = Color(0xFFFBBF24);

  // ─── Named Gradients ───
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [purple, magenta, orange],
  );

  static const LinearGradient techGradient = LinearGradient(
    colors: [cyan, purple],
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [purple, magenta, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient timelineGradient = LinearGradient(
    colors: [purple, cyan],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [teal, green],
  );
}

