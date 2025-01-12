import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget prefixIcon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      obscureText: obscureText,
      cursorColor: Colors.black87,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black87,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black87,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
