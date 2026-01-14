import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:hf_shop/data/repositories/banner/banner_repository.dart';
import 'package:hf_shop/features/shop/models/banners_model.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final _repository = Get.put(BannerRepository());
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxBool isLoading = false.obs;

    // variables
  final CarouselSliderController carouselController = CarouselSliderController();
  RxInt currentIndex = 0.obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

    // on carousel page changed
  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      List<BannerModel> activeBanners = await _repository.fetchActiveBanners();
      banners.assignAll(activeBanners);
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
