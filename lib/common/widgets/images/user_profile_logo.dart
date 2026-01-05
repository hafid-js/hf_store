import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/images/circular_image.dart';
import 'package:hf_shop/features/personalization/controllers/user_controller.dart';
import 'package:hf_shop/utils/constants/images.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    bool isProfileAvailable = controller.user.value.profilePicture.isNotEmpty;
    return UCircularImage(
      image: isProfileAvailable
          ? controller.user.value.profilePicture
          : UImages.profileLogo,
      height: 120.0,
      width: 120.0,
      borderWidth: 5.0,
      padding: 0,
      isNetworkImage: isProfileAvailable
    );
  }
}
