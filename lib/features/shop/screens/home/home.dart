import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/textfields/search_bar.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/home_categories.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/primary_header_container.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // total height + 20
          SizedBox(height: USizes.homePrimaryHeaderHeight + 20),

          // primary header container
          UPrimaryHeaderContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UHomeAppBar(),
                SizedBox(height: USizes.spaceBtwSections),

                // home categories
                UHomeCategories()
              ],
            ),
          ),

          USearchBar(),
        ],
      ),
    );
  }
}
