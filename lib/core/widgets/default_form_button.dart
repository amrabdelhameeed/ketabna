import 'package:flutter/material.dart';
import 'package:ketabna/core/utils/app_colors.dart';

class DefaultFormButton extends StatelessWidget {
  DefaultFormButton(
      {Key? key,
        this.width = double.infinity,
        this.height = 65,
        this.radius = 20,
        this.padding = 20,
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
  double width ;
  double height ;
  double radius  ;
  double padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        padding:  EdgeInsets.symmetric(vertical: padding),
        width: width,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontFamily: 'SFPro',
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(color: AppColors.secondaryColor),
            borderRadius:  BorderRadius.all(Radius.circular(radius))),
      ),
    );
  }
}
