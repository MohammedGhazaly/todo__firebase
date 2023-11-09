import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final String text;
  final void Function()? onPressedFunction;
  final bool isLoading;
  const CustomAuthButton({
    super.key,
    required this.text,
    this.onPressedFunction,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: TextButton(
          onPressed: onPressedFunction,
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          child: isLoading == true
              ? Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(color: Colors.white),
                )),
    );
  }
}
