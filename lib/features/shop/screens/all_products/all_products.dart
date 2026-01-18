import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/style/padding.dart';
import 'package:hf_shop/common/widgets/appbar/appbar.dart';
import 'package:hf_shop/common/widgets/products/sortable_products.dart';
import 'package:hf_shop/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:hf_shop/features/shop/controllers/product/all_product_controller.dart';
import 'package:hf_shop/features/shop/models/product_model.dart';
import 'package:hf_shop/utils/constants/helpers/cloud_helper_functions.dart';
class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, this.futureMethod, this.query, required this.title});

final String title;
  final Future<List<ProductModel>>? futureMethod;
  final Query? query;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: FutureBuilder(future: futureMethod ?? controller.fetchProductsByQuery(query), builder: (context, snapshot) {

            const loader = UVerticalProductShimmer();
            final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
            if(widget != null) return widget;

            final products = snapshot.data!;
            return USortableProducts(products: products);
          })
        ),
      ),
    );
  }
}