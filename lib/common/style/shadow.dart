import 'package:flutter/material.dart';

class UShadow {
  UShadow._();

  static List<BoxShadow> searchBarShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      spreadRadius: 4.0,
      blurRadius: 4.0,
    ),
  ];
}