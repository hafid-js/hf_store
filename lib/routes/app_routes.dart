
import 'package:get/get.dart';
import 'package:hf_shop/features/personalization/screens/address/address.dart';
import 'package:hf_shop/features/personalization/screens/edit_profile/edit_profile.dart';
import 'package:hf_shop/features/personalization/screens/profile/profile.dart';
import 'package:hf_shop/features/shop/screens/store/store.dart';
import 'package:hf_shop/features/shop/screens/wishlist/wishlist.dart';
import 'package:hf_shop/navigation_menu.dart';
import 'package:hf_shop/routes/routes.dart';

import '../features/authentication/screens/forget_password/forget_password.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/shop/screens/cart/cart.dart';
import '../features/shop/screens/checkout/checkout.dart';
import '../features/shop/screens/order/order.dart';

class UAppRoutes{

  static final screens = [
    GetPage(name: URoutes.home, page: () => const NavigationMenu()),
    GetPage(name: URoutes.store, page: () => const StoreScreen(),),
    GetPage(name: URoutes.wishlist, page: () => const WishlistScreen(),),
    GetPage(name: URoutes.profile, page: () => const ProfileScreen(),),
    GetPage(name: URoutes.order, page: () => const OrderScreen(),),
    GetPage(name: URoutes.checkout, page: () => const CheckoutScreen(),),
    GetPage(name: URoutes.cart, page: () => const CartScreen(),),
    GetPage(name: URoutes.editProfile, page: () => const EditProfileScreen(),),
    GetPage(name: URoutes.userAddress, page: () => const AddressScreen(),),
    GetPage(name: URoutes.signup, page: () => const SignupScreen(),),
    GetPage(name: URoutes.verifyEmail, page: () => const VerifyEmailScreen(email: 'tapi.ngapain@gmail.com',),),
    GetPage(name: URoutes.signIn, page: () => const LoginScreen(),),
    GetPage(name: URoutes.forgetPassword, page: () => const ForgetPasswordScreen(),),
    GetPage(name: URoutes.onBoarding, page: () => const OnBoardingScreen(),),
  ];
}