
import 'package:flutter/material.dart';
import 'package:hf_shop/features/authentication/screens/onboarding/onboarding.dart';
import 'package:hf_shop/utils/constants/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      home: OnBoardingScreen(),
    );
  }
}
