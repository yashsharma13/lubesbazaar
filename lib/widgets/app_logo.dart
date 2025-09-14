import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/styles.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final EdgeInsetsGeometry? margin;

  const AppLogo({super.key, this.height, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? AppLogoStyles.margin,
      child: Image.asset(
        "assets/images/lubesbazaar.png",
        height: height ?? AppLogoStyles.height,
      ),
    );
  }
}
