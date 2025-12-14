import 'package:flutter/material.dart';
import 'package:hf_shop/utils/constants/colors.dart';

class UShadow {
  UShadow._();

  static List<BoxShadow> searchBarShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      spreadRadius: 4.0,
      blurRadius: 4.0,
    ),
  ];

  static List<BoxShadow> verticalProductShadow = [
    BoxShadow(
      color: UColors.darkGrey.withValues(alpha: 0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2),
    ),
  ];
}
