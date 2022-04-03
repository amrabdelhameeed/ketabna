import 'package:flutter/material.dart';
import 'package:ketabna/core/utils/app_colors.dart';

class DefaultFormButton extends StatelessWidget {
  DefaultFormButton({Key? key, this.onPressed}) : super(key: key);

  final VoidCallback? onPressed;
  Color textColor = AppColors.secondaryColor;
  Color fillColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: const Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontFamily: 'SFPro',
              fontSize: 17.0,
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
