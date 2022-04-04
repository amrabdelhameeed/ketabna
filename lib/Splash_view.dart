
import 'dart:async';

import 'package:flutter/material.dart';

import 'onBoarding_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);



  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  bool showMessage = true;
  double opacity = 0 ;

  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 8), go);
    Future.delayed(Duration(seconds: 0),(){
      setState(() {
        opacity=1;
        showMessage=!showMessage;

      });
    });
  }

  void go (){
    Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
        builder: (context) => onBoardingScreen()
    ), (route) => false);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefe9c2),

      body: Stack(
        children: [
          Positioned(
            top:  MediaQuery.of(context).size.height/2,
            left:  MediaQuery.of(context).size.width/5,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: AlignmentDirectional.centerStart,
                  child: AnimatedOpacity(
                    child: Text(
                      'Borrowed Books',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xfff5b53f)),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                    duration: Duration(seconds: 6), opacity: opacity,
                  ),
                ),
              ),
          ),
          AnimatedPositioned(

              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width*18/20,
                child: Image(
                  image: AssetImage('assets/images/Books.png'),
                ),
              ),
              duration: Duration(seconds: 4),
              curve: Curves.bounceIn,
              top: !showMessage ? 100 :MediaQuery.of(context).size.height/3,
            left: MediaQuery.of(context).size.width/20,
          )
        ],
      ),
    );
  }
}


