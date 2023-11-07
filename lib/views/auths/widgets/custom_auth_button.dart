import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final String text;
  final void Function()? onPressedFunction;
  const CustomAuthButton({
    super.key,
    required this.text,
    this.onPressedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: ,
      child: TextButton(
        onPressed: onPressedFunction,
        style: TextButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
