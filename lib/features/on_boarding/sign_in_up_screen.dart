import 'package:flutter/material.dart';
import 'package:ketabna/core/constants/strings.dart';

import '../../core/utils/size_config.dart';

class SignInUPScreen extends StatelessWidget {
  SignInUPScreen({Key? key}) : super(key: key);

  DateTime pre_backpress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // double sizeH = MediaQuery.of(context).size.height as double;
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);

        final cantExit = timegap >= Duration(seconds: 2);

        pre_backpress = DateTime.now();

        if (cantExit) {
          //show snackbar
          final snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F1D7),
        body: Stack(
          children: [
            ///flower1 TopRight
            Positioned(
              right: -120,
              top: 20,
              child: Transform.rotate(
                angle: .005,
                child: const Image(
                  image: AssetImage('assets/image/f.png'),
                ),
              ),
            ),

            ///flower2 TopRight
            Positioned(
              right: -66,
              top: 220,
              child: Transform.rotate(
                angle: -.04,
                child: const Image(
                  image: AssetImage('assets/image/f2.png'),
                ),
              ),
            ),

            /// flower3 TopLeft
            Positioned(
              left: -50,
              child: Image(
                image: const AssetImage('assets/image/f3.png'),
                fit: BoxFit.values[2],
                width: 120,
                height: 350,
              ),
            ),

            Positioned(
              height: SizeConfig.screenHeight,
              width: (SizeConfig.screenWidth)! / 1,
              top: SizeConfig.screenHeight! / 3.2,
              left: -70,
              child: const Image(
                image: AssetImage('assets/image/b.png'),
              ),
            ),

            /// Text And Button
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight! / 5.5,
                  ),

                  /// Title
                  const Text(
                    'Books For \nEveryone.',
                    style: TextStyle(
                      fontFamily: 'SF Pro Rounded',
                      fontStyle: FontStyle.normal,
                      fontSize: 38,
                      color: Color(0xfff5b53f),
                      letterSpacing: 0.36,
                      fontWeight: FontWeight.normal,
                      height: 1.1111111111111112,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: SizeConfig.screenHeight! / 8,
                  ),

                  /// Sign In Button
                  Container(
                    height: SizeConfig.screenHeight! / 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 181, 63, .93),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, loginScreen);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: false,
                      ),
                      elevation: 0.0,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! / 68,
                  ),

                  /// Sign Up Button
                  Container(
                    height: SizeConfig.screenHeight! / 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 181, 63, .93),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, registerScreen);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: false,
                      ),
                      elevation: 0.0,
                    ),
                  ),
                ],
              ),
            ),

            ///Girl
            Positioned(
              left: -90,
              bottom: -40,
              child: Image(
                image: const AssetImage('assets/image/G.png'),
                width: SizeConfig.screenWidth! / 1.15,
                height: SizeConfig.screenHeight! / 2.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
