import 'package:flutter/material.dart';
import 'package:ketabna/core/utils/app_colors.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField(
      {Key? key,
      required this.hint,
      this.controller,
      this.inputType,
      this.isPassword = false,
      this.validationText})
      : super(key: key);
  final String hint;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool? isPassword;
  final String? validationText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword!,
      keyboardType: inputType,
      style: const TextStyle(
        color: AppColors.formFontColor,
      ),
      validator: (error) {
        if (controller!.text.isEmpty) {
          return validationText;
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20.0),
        hintText: hint,
        errorStyle: const TextStyle(
          fontFamily: 'SFPro',
        ),
        fillColor: const Color(0xFFEFEFEF),
        filled: true,
        hintStyle: const TextStyle(
          fontSize: 15.0,
          color: AppColors.formFontColor,
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
