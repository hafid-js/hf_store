import 'package:flutter/material.dart';
import 'package:hf_shop/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:hf_shop/common/widgets/images/user_profile_logo.dart';
import 'package:hf_shop/utils/constants/sizes.dart';

class UProfilePrimaryHeader extends StatelessWidget {
  const UProfilePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: USizes.profilePrimaryHeaderHeight + 60),
    
        UPrimaryHeaderContainer(
          height: USizes.profilePrimaryHeaderHeight,
          child: Container(),
        ),
    
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: UserProfileLogo(),
          )),
      ],
    );
  }
}