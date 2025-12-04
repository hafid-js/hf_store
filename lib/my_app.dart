import 'package:flutter/material.dart';
import 'package:hf_shop/utils/constants/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      home: Scaffold(),
    );
  }
}