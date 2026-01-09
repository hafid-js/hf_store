import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/features/personalization/controllers/user_controller.dart';
import 'package:hf_shop/features/personalization/screens/change_name/change_name.dart';
import 'package:hf_shop/features/personalization/screens/edit_profile/widgets/user_profile_with_edit_icon.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Obx(() {
        final user = controller.user.value;

        return SingleChildScrollView(
          child: Padding(
            padding: UPadding.screenPadding,
            child: Column(
              children: [
                UserProfileWithEditIcon(),
                SizedBox(height: USizes.spaceBtwSections),
                Divider(),
                SizedBox(height: USizes.spaceBtwItems),
                USectionHeading(
                  title: 'Account Settings',
                  showActionButton: false,
                ),
                UserDetailRow(
                  title: 'Name',
                  value: user.fullName,
                  onTap: () => Get.to(() => ChangeNameScreen()),
                ),
                UserDetailRow(
                  title: 'Username',
                  value: user.username,
                  onTap: () {},
                ),
                SizedBox(height: USizes.spaceBtwItems),
                Divider(),
                SizedBox(height: USizes.spaceBtwItems),
                USectionHeading(
                  title: 'Profile Settings',
                  showActionButton: false,
                ),
                UserDetailRow(
                  title: 'User ID',
                  value: user.id,
                  onTap: () {},
                ),
                UserDetailRow(
                  title: 'Email',
                  value: user.email,
                  onTap: () {},
                ),
                UserDetailRow(
                  title: 'Phone Number',
                  value: user.phoneNumber,
                  onTap: () {},
                ),
                SizedBox(height: USizes.spaceBtwItems),
                Divider(),
                SizedBox(height: USizes.spaceBtwItems),
                TextButton(
                  onPressed: controller.deleteAccountWarningPopup,
                  child: Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class UserDetailRow extends StatelessWidget {
  const UserDetailRow({
    super.key,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
    required this.onTap,
  });

  final String title, value;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: USizes.spaceBtwItems / 1.5,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: Icon(icon, size: USizes.iconSm)),
          ],
        ),
      ),
    );
  }
}
