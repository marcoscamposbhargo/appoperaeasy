import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operaeasy_app/config/theme.dart';
import 'package:operaeasy_app/screens/order_detail_screen.dart';
import 'package:operaeasy_app/screens/history_screen.dart';
import 'package:operaeasy_app/screens/login_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: OperaEasyApp(),
    ),
  );
}

class OperaEasyApp extends StatelessWidget {
  const OperaEasyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OperaEasy',
      theme: OperaEasyTheme.lightTheme(),
      darkTheme: OperaEasyTheme.darkTheme(),
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/order-detail') {
          final orderId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => OrderDetailScreen(orderId: orderId),
          );
        }
        if (settings.name == '/history') {
          return MaterialPageRoute(
            builder: (context) => const HistoryScreen(),
          );
        }
        return null;
      },
    );
  }
}
