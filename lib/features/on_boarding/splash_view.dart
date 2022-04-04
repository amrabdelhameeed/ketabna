import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/features/on_boarding/on_boarding_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool showMessage = true;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), go);
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        opacity = 1;
        showMessage = !showMessage;
      });
    });
  }

  void go() {
    Navigator.pushReplacementNamed(context, onBoardingScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefe9c2),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: AlignmentDirectional.center,
                child: AnimatedOpacity(
                  child: const Text(
                    'Borrowed Books',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xfff5b53f)),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  duration: const Duration(seconds: 6),
                  opacity: opacity,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            child: SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Image(
                image: AssetImage('assets/image/Books.png'),
              ),
            ),
            duration: const Duration(seconds: 4),
            curve: Curves.bounceIn,
            top: !showMessage ? 100 : MediaQuery.of(context).size.height / 3,
            left: MediaQuery.of(context).size.width / 20,
          )
        ],
      ),
    );
  }
}
