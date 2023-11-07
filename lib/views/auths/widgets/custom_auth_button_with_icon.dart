import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAuthButtonWithIcon extends StatelessWidget {
  final String text;
  final void Function()? onPressedFunction;
  final Widget icon;
  const CustomAuthButtonWithIcon({
    super.key,
    required this.text,
    this.onPressedFunction,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: ,
      child: TextButton.icon(
        onPressed: onPressedFunction,
        style: TextButton.styleFrom(
          backgroundColor: Colors.red[700],
          foregroundColor: Colors.white,
        ),
        icon: const FaIcon(FontAwesomeIcons.google),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
