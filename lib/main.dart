import 'package:classified_app/routes/route_generator.dart';
import 'package:classified_app/styles/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      initialRoute: '/login',
      onGenerateRoute: RouteGenerator().routes,
    );
  }
}
