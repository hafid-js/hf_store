
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/bindings/bindings.dart';
import 'package:hf_shop/routes/app_routes.dart';
import 'package:hf_shop/utils/constants/colors.dart';
import 'package:hf_shop/utils/constants/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      getPages: UAppRoutes.screens,
      initialBinding: UBindings(),
      // home: OnBoardingScreen(),
      home: Scaffold(
        backgroundColor: UColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: UColors.white,
          ),
        ),
      )
    );
  }
}
