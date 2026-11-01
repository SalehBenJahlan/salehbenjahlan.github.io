import 'package:flutter/material.dart';

/// Global application state: language (EN/AR) and theme (dark/light).
class AppState extends ChangeNotifier {
  bool _isArabic = false;
  bool _isDarkMode = true;

  bool get isArabic => _isArabic;
  bool get isDarkMode => _isDarkMode;
  TextDirection get textDirection =>
      _isArabic ? TextDirection.rtl : TextDirection.ltr;

  void toggleLanguage() {
    _isArabic = !_isArabic;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

/// InheritedNotifier so descendants rebuild when [AppState] changes.
class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({
    required AppState super.notifier,
    required super.child,
    super.key,
  });

  /// Returns [AppState] and registers a dependency (rebuilds on changes).
  static AppState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppStateProvider>()!
        .notifier!;
  }

  /// Returns [AppState] without registering a dependency (one-time read).
  static AppState read(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<AppStateProvider>()!;
    return (element.widget as AppStateProvider).notifier!;
  }
}

