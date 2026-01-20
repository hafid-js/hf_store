import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hf_shop/data/repositories/user/user_repository.dart';
import 'package:hf_shop/features/authentication/screens/login/login.dart';
import 'package:hf_shop/features/authentication/screens/onboarding/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hf_shop/features/authentication/screens/signup/verify_email.dart';
import 'package:hf_shop/features/personalization/controllers/user_controller.dart';
import 'package:hf_shop/navigation_menu.dart';
import 'package:hf_shop/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:hf_shop/utils/exceptions/firebase_exceptions.dart';
import 'package:hf_shop/utils/exceptions/format_exceptions.dart';
import 'package:hf_shop/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final localStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final storage = GetStorage('userId');

  User? get currentUser => _auth.currentUser;
  @override
  void onReady() {
    FlutterNativeSplash.remove();

    screenRedirect();

    // Get.put(CategoryRepository()).uploadCategories(UDummyData.categories);
    // Get.put(CategoryRepository()).uploadBrandCategory(UDummyData.brandCategory);
    //   Get.put(CategoryRepository()).uploadProductCategory(UDummyData.productCategory);
    // Get.put(BannerRepository()).uploadBanners(UDummyData.banner);
    // Get.put(BrandRepository()).uploadBrands(UDummyData.brands);
    // Get.put(ProductRepository()).uploadProducts(UDummyData.products);
  }

  Future<void> screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => NavigationMenu());
        await GetStorage.init(user.uid);
      } else {
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
      
    } else {
      localStorage.writeIfNull('isFirstTime', true);

      localStorage.read('isFirstTime') != true
          ? Get.to(() => LoginScreen())
          : Get.to(() => OnBoardingScreen());
    }
  }

  Future<UserCredential> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  Future<UserCredential> loginWithEmailAndPAssword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleAccount?.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  Future<void> reAuthenticationUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(currentUser!.uid);

      String publicId = UserController.instance.user.value.publicId;
      if (publicId.isNotEmpty) {
        UserRepository.instance.deleteProfilePicture(publicId);
      }
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again!';
    }
  }
}
