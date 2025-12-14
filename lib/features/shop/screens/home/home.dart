import 'package:flutter/material.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/primary_header_container.dart';
import 'package:hf_shop/utils/constants/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: UPrimaryHeaderContainer(
        child: Column(
          children: [
            UHomeAppBar(dark: dark),
          ],
        ),
      ),
    );
  }
}