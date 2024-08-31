import 'package:e_commerce/views/components/appstyle.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboard,
    this.suffixIcon,
    this.obscureText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  // final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: TextFormField(
          keyboardType: keyboard,
          obscureText: obscureText ?? false,
          // initialValue: initialValue,
          decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              suffixIconColor: Colors.blue,
              hintStyle: appstyle(14, Colors.blue, FontWeight.w500),
              // contentPadding: EdgeInsets.only(left: 24),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.red, width: 0.5),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.red, width: 0.5),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey, width: 0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              border: InputBorder.none),
          controller: controller,
          cursorHeight: 25,
          style: appstyle(14, Colors.blue, FontWeight.w500),
          validator: validator),
    );
  }
}
