import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController textEditingController;
  const CustomFormTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: textEditingController,
          cursorColor: Colors.orange,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        )
      ],
    );
  }
}