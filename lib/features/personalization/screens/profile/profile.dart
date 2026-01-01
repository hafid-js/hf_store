import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/personalization/screens/address/address.dart';
import 'package:hf_shop/features/personalization/screens/profile/widgets/profile_primary_header.dart';
import 'package:hf_shop/features/personalization/screens/profile/widgets/settings_menu_tile.dart';
import 'package:hf_shop/features/personalization/screens/profile/widgets/user_profile_tile.dart';
import 'package:hf_shop/features/shop/screens/order/order.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProfilePrimaryHeader(),

            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  UserProfileTile(),
                  SizedBox(height: USizes.spaceBtwItems),

                  USectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),

                  SettingsMenuTile(
                    onTap: () => Get.to(() => AddressScreen()),
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery addresses',
                  ),
                  SettingsMenuTile(
                    onTap: () {},
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout',
                  ),
                  SettingsMenuTile(
                     onTap: () => Get.to(() => OrderScreen()),
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                  ),

                  SizedBox(height: USizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Logout'),
                    ),
                  ),
                  SizedBox(height: USizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
