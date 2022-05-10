import 'package:flutter/material.dart';
import 'package:ketabna/core/utils/app_colors.dart';

class DefaultFormButton extends StatelessWidget {
  DefaultFormButton(
      {Key? key,
      this.onPressed,
      required this.text,
      this.fillColor,
      this.textColor,
      this.fontSize})
      : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  Color? textColor = AppColors.secondaryColor;
  Color? fillColor = Colors.transparent;
  double? fontSize = 17.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontFamily: 'SFPro',
              fontSize: fontSize,
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(color: AppColors.secondaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      ),
    );
  }
}
