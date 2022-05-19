import 'package:flutter/material.dart';
import 'package:ketabna/core/utils/app_colors.dart';
// Updated by Baly
class DefaultTextFormField extends StatefulWidget {
   DefaultTextFormField(
      {Key? key,
      required this.hint,
        this.controller,
      this.inputType,
      this.isPassword = false,
      this.validationText,
      })
      : super(key: key);
  final String hint;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool? isPassword;
  final String? validationText;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool showPass=false ;

  IconData suffix = Icons.visibility_off_outlined;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword! ? showPass: false,
      keyboardType: widget.inputType,
      style: const TextStyle(
        color: AppColors.formFontColor,
      ),
      validator: (error) {
        if (widget.controller!.text.isEmpty) {
          return widget.validationText;
        }
        return null;

      },
      decoration: InputDecoration(
        suffixIcon: widget.isPassword! ?
        MaterialButton(
          elevation: 0,

            onPressed:(){
              setState(() {
                // new
                showPass = !showPass;
                suffix = showPass ?  Icons.visibility_outlined :  Icons.visibility_off_outlined;
              });
             },
          child: Icon(suffix) ,
        ) : SizedBox() ,
        contentPadding: const EdgeInsets.all(20.0),
        hintText: widget.hint,
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
