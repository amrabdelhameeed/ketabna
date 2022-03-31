
//   Write by BALY

import 'package:flutter/material.dart';

Widget textFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required final label,
  double radius = 0,
  int? maxLength,
  Function? onTab,
  double ? labelSized,
  bool obscureText = false,
}) {
  return TextFormField(
    onTap: (){onTab!();},
    maxLength: maxLength,
    controller: TextEditingController(),
    obscureText: obscureText,
    keyboardType: keyboardType,
    decoration:  InputDecoration(
      labelStyle: TextStyle(
        fontSize: labelSized,

      ),

      hintMaxLines: maxLength,
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    ),
  );
}

