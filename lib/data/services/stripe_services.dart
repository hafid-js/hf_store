import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:hf_shop/utils/constants/apis.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hf_shop/utils/constants/keys.dart';

class StripeServices extends GetxController {
  static StripeServices get instance => Get.find();

  final _dio = dio.Dio();

  Future<dynamic> createPaymentIntents(String currency, int amount) async {
    try {
      String url = UApiUrls.stripeCreateIntents;

      final data = {
        'currency': currency,
        'amount': amount,
        'payment_method_types[]': 'card',
      };

      dio.Response response = await _dio.post(
        url,
        data: data,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer ${UKeys.stripeSecretKey}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      throw 'Something went wrong while creating payment intents';
    }
  }

  Future<void> initPaymentSheet(String currency, int amount) async {
    try {
      // 1. Create payment intent on the server
      final data = await createPaymentIntents(currency, amount);
      log(data.toString());

      // 2. Create billing details (optional)
      final billingDetails = BillingDetails(
        name: 'Flutter Stripe',
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      );

      // 3. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          paymentIntentClientSecret: data['client_secret'],
          merchantDisplayName: 'HF Shopping APP',
          // Customer params
          customerId: data['id'],
          returnURL: 'flutterstripe://redirect',
          // Extra options
          primaryButtonLabel: 'Pay now',
          // applePay: PaymentSheetApplePay(
          //   merchantCountryCode: 'US',
          // ),
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),
          style: ThemeMode.dark,
          billingDetails: billingDetails,
        ),
      );
    } catch (e) {
      throw 'Something went wrong while initializing the payment sheet';
    }
  }

  Future<void> showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      switch (e.error.code) {
        case FailureCode.Canceled:
          throw 'Payment Canceled';
        case FailureCode.Failed:
          throw 'Payment Failed';
        case FailureCode.Timeout:
          throw 'Payment Timeout';
        case FailureCode.Unknown:
          throw 'An unknown error occured';
      }
    } catch (e) {
      throw 'Something went wrong while showing the payment sheet';
    }
  }
}
