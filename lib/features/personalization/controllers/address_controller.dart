import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hf_shop/common/widgets/loaders/circular_loader.dart';
import 'package:hf_shop/common/widgets/texts/section_heading.dart';
import 'package:hf_shop/data/repositories/address/address_repository.dart';
import 'package:hf_shop/features/personalization/models/address_model.dart';
import 'package:hf_shop/features/personalization/screens/address/widgets/single_address.dart';
import 'package:hf_shop/utils/constants/helpers/cloud_helper_functions.dart';
import 'package:hf_shop/utils/constants/helpers/network_manager.dart';
import 'package:hf_shop/utils/constants/sizes.dart';
import 'package:hf_shop/utils/popups/full_screen_loader.dart';
import 'package:hf_shop/utils/popups/snackbar_helpers.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final _repository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = false.obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final postalCode = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  Future<void> addNewAddress() async {
    try {
      UFullScreenLoader.openLoadingDialog('Storing Address...');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }
      if (!addressFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      AddressModel address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        dateTime: DateTime.now(),
      );

      String addressId = await _repository.addAddress(address);
      address.id = addressId;

      selectedAddress(address);

      UFullScreenLoader.stopLoading();

      USnackBarHelpers.successSnackBar(
        title: 'Congratualations!',
        message: 'Address added successfully.',
      );

      refreshData.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }
  }

  Future<List<AddressModel>> getAllAddresses() async {
    try {
      List<AddressModel> addresses = await _repository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (address) => address.selectedAddress,
        orElse: () => AddressModel.empty(),
      );

      return addresses;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }

  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: UCircularLoader(),
      );

      if (selectedAddress.value.id.isNotEmpty) {
        await _repository.updateSelectedField(selectedAddress.value.id, false);
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await _repository.updateSelectedField(selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      Get.back();
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }
  }

  Future<void> selectNewAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(USizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              USectionHeading(title: 'Select Address', showActionButton: false),
              SizedBox(height: USizes.spaceBtwItems),
              FutureBuilder(
                future: getAllAddresses(),
                builder: (context, snapshot) {
                  final widget = UCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                  );
                  if (widget != null) return widget;

                  return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: USizes.spaceBtwItems),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => USingleAddress(
                      address: snapshot.data![index],
                      onTap: () {
                        selectAddress(snapshot.data![index]);
                        Get.back();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    city.clear();
    state.clear();
    postalCode.clear();

    addressFormKey.currentState?.reset();
  }
}
