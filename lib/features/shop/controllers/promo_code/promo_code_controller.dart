import 'package:get/get.dart';
import 'package:hf_shop/data/repositories/authentication_repository.dart';
import 'package:hf_shop/data/repositories/promo_code/promo_code_repository.dart';
import 'package:hf_shop/features/shop/controllers/cart/cart_controller.dart';
import 'package:hf_shop/features/shop/models/promo_code.dart';
import 'package:hf_shop/utils/constants/enums.dart';
import 'package:hf_shop/utils/constants/helpers/network_manager.dart';
import 'package:hf_shop/utils/constants/helpers/pricing_calculator.dart';
import 'package:hf_shop/utils/constants/texts.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class PromoCodeController extends GetxController {
  static PromoCodeController get instance => Get.find();

  final _repository = Get.put(PromoCodeRepository());
  RxString promoCode = ''.obs;
  RxBool isLoading = false.obs;
  final cartController = CartController.instance;
  Rx<PromoCodeModel> appliedPromoCode = PromoCodeModel.empty().obs;

  void onPromoChanged(String value) => promoCode.value = value;

  Future<void> applyPromoCode() async {
    try {
      isLoading.value = true;

      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        USnackBarHelpers.warningSnackBar(
          title: 'No Internet Connection',
          message: 'Please check your internet connection!',
        );
        return;
      }

      PromoCodeModel promoCode = await _repository.fetchSinglePromoCode(
        this.promoCode.value,
      );
      if (promoCode.id.isEmpty) {
        USnackBarHelpers.warningSnackBar(
          title: 'Invalid Promo Code',
          message: 'Please enter a valid promo code',
        );
        return;
      }

      DateTime now = DateTime.now();
      if (promoCode.endDate!.isBefore(now)) {
        USnackBarHelpers.warningSnackBar(
          title: 'Promo Code Expired',
          message: 'This promo code has expired!',
        );
        return;
      }

      if (!promoCode.isActive) {
        USnackBarHelpers.warningSnackBar(
          title: 'Promo Code Not Active',
          message: 'This promo code not active!',
        );
        return;
      }

      double subTotal = cartController.totalCartPrice.value;
      double totalPrice = UPricingCalculator.calculateTotalPrice(
        subTotal,
        'Indonesia',
      );
      if (!(totalPrice >= promoCode.minOrderPrice)) {
        USnackBarHelpers.warningSnackBar(
          title: 'Promo Code Not Applicable',
          message:
              'Minimum Order Amount Must be ${UTexts.currency}${promoCode.minOrderPrice.toStringAsFixed((0))} to use this Code',
        );
        return;
      }

      if (!(promoCode.noOfPromoCodes > 0)) {
        USnackBarHelpers.warningSnackBar(
          title: 'Promo Code Expired',
          message: 'This promo cpde has expired!',
        );
        return;
      }

      List<String> userIds = promoCode.userIds ?? [];
      String currentUserId = AuthenticationRepository.instance.currentUser!.uid;
      if(userIds.contains(currentUserId)) {
        USnackBarHelpers.warningSnackBar(title: 'Already Applied', message: 'You have already applied this promo code');
        return;
      }


      appliedPromoCode.value = promoCode;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(
        title: 'Promo Code Error',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  double calculatePriceAfterDiscount(
    PromoCodeModel promoCode,
    double totalPrice,
  ) {
    if (promoCode.id.isNotEmpty) {
      if (promoCode.discountType == DiscountType.percentage) {
        return UPricingCalculator.calculatePercentageDiscount(
          totalPrice,
          promoCode.discount,
        );
      } else {
        return UPricingCalculator.calculateFixedDiscount(
          totalPrice,
          promoCode.discount,
        );
      }
    }

    return totalPrice;
  }

  String getDiscountPrice() {
    if (appliedPromoCode.value.id.isEmpty) return '';

    if (appliedPromoCode.value.discountType == DiscountType.percentage) {
      return '${appliedPromoCode.value.discount}%';
    } else {
      return '${UTexts.currency}${appliedPromoCode.value.discount}';
    }
  }

  Future<void> decreaseNoOfPomoCodes() async {
    try {
      if (appliedPromoCode.value.id.isEmpty) return;
      int noOfPromoCodes = appliedPromoCode.value.noOfPromoCodes - 1;
      _repository.updateSingleField(
        appliedPromoCode.value,
        'noOfPromoCodes',
        noOfPromoCodes,
      );
    } catch (e) {
      USnackBarHelpers.errorSnackBar(
        title: 'Promo Code Error',
        message: e.toString(),
      );
    }
  }

  Future<void> addUserToPromoCode() async {
    try {
      if (appliedPromoCode.value.id.isEmpty) return;
      List<String> userIds = appliedPromoCode.value.userIds ?? [];
      userIds.add(AuthenticationRepository.instance.currentUser!.uid);
      await _repository.updateSingleField(
        appliedPromoCode.value,
        'userIds',
        userIds,
      );
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
