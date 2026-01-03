import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:hf_shop/utils/constants/helpers/network_manager.dart';

class UBindings extends Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.put(NetworkManager());
    }
  }
  
}