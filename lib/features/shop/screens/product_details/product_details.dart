import 'package:flutter/material.dart';
import 'package:hf_shop/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:hf_shop/features/shop/screens/product_details/widgets/product_thumbnail_and_slider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProductThumbnailAndSlider(),

            UProductMetaData(),
          ],
        ),
      ),
    );
  }
}