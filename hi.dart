import 'package:flutter/material.dart';

class Hi extends StatelessWidget {
  const Hi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: Text('hello'),
      ),
    );
  }
}
