import 'package:flutter/material.dart';
import 'core/state/app_state.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState();
  runApp(PortfolioApp(appState: appState));
}
