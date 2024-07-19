import 'package:flutter/material.dart';
import 'package:gra_app/core/di/dependency_injection.dart';
import 'package:gra_app/features/presentation/home/home_page.dart';
import 'package:logging/logging.dart';

void main() {
  hierarchicalLoggingEnabled = true;
  setupInjection();
  runApp(const MyDashboardApp());
}

class MyDashboardApp extends StatelessWidget {
  const MyDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
