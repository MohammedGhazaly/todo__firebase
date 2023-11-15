import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 45,
            height: 45,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
