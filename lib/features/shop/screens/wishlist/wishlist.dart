import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/icons/circular_icon.dart';
import 'package:hf_shop/common/widgets/layouts/grid_layout.dart';
import 'package:hf_shop/common/widgets/loaders/animation_loader.dart';
import 'package:hf_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:hf_shop/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:hf_shop/features/shop/controllers/product/favourite_controller.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/navigation_menu.dart';
import 'package:hf_shop/utils/constants/helpers/cloud_helper_functions.dart';
import 'package:hf_shop/utils/constants/images.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          UCircularIcon(
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              future: FavouriteController.instance.getFavouritesProducts(),
              builder: (context, snapshot) {
                final nothingFound = UAnimationLoader(
                  text: 'Wishlist is Empty...',
                  animation: UImages.pencilAnimation,
                  showActionButton: true,
                  actionText: "Let's add some",
                  onActionPressed: () =>
                      NavigationController.instance.selectedIndex.value = 0,
                );
                const loader = UVerticalProductShimmer(itemCount: 6);
                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                  nothingFound: nothingFound,
                );
                if (widget != null) return widget;

                List<ProductModel> products = snapshot.data!;
                return UGridLayout(
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      UProductCardVertical(product: products[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
