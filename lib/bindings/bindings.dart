import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:hf_shop/features/personalization/controllers/user_controller.dart';
import 'package:hf_shop/features/shop/controllers/home/home_controller.dart';
import 'package:hf_shop/features/shop/controllers/product/variation_controller.dart';
import 'package:hf_shop/utils/constants/helpers/network_manager.dart';

class UBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(HomeController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(VariationController(), permanent: true);
  }
}
