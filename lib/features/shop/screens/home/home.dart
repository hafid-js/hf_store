import 'package:flutter/material.dart';
import 'package:hf_shop/features/shop/screens/home/widgets/primary_header_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UPrimaryHeaderContainer(),
    );
  }
}
