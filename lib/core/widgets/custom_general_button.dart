import 'package:flutter/material.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/utils/size_config.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({Key? key, this.text, this.color, this.callback})
      : super(key: key);
  final String? text;
  final VoidCallback? callback;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: SizeConfig.screenWidth,
        height: 60,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          text ?? "Next",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
