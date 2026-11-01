import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/state/app_state.dart';
import 'homepage.dart';

class PortfolioApp extends StatelessWidget {
  final AppState appState;

  const PortfolioApp({required this.appState, super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      notifier: appState,
      child: ListenableBuilder(
        listenable: appState,
        builder: (context, _) {
          return MaterialApp(
            title: appState.isArabic
                ? 'صالح بن جهلان | مطور فلاتر'
                : 'Saleh Ben Jahlan | Flutter Developer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode:
                appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            builder: (context, child) {
              return Directionality(
                textDirection: appState.textDirection,
                child: child!,
              );
            },
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

