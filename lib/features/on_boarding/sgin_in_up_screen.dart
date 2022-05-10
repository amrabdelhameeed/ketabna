import 'package:flutter/material.dart';
import 'package:ketabna/core/constants/strings.dart';

class SignInUpScreen extends StatelessWidget {
  const SignInUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1D7),
      body: Stack(
        children: [
          ///flower1 TopRight
          Align(
            alignment: const AlignmentDirectional(3.5, -.6),
            child: Transform.rotate(
              angle: .1,
              child: const Image(
                image: AssetImage('assets/image/f.png'),
                height: 200,
                width: 250,
              ),
            ),
          ),

          ///flower2 TopRight
          Align(
            alignment: const AlignmentDirectional(1.67, -.16),
            child: Transform.rotate(
              angle: 0,
              child: const Image(
                image: AssetImage('assets/image/f2.png'),
                height: 110,
                width: 140,
              ),
            ),
          ),

          /// flower3 TopLeft
          const Align(
            alignment: AlignmentDirectional(-3.9, -1),
            child: Image(
              image: AssetImage('assets/image/f3.png'),
              height: 380,
              width: 270,
            ),
          ),
          const Align(
            alignment: AlignmentDirectional(-22, .99),
            child: Image(
              image: AssetImage('assets/image/b.png'),
              width: 348,
              height: 260,
              fit: BoxFit.fill,
            ),
          ),

          /// Text And Button
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 130,
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
                const SizedBox(
                  height: 90,
                ),

                /// Sign In Button
                Container(
                  height: 56,
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

                const SizedBox(
                  height: 10,
                ),

                /// Sign Up Button
                Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 181, 63, .93),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, registerScreen);
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
          const Align(
            alignment: AlignmentDirectional(-4, 1),
            child: Image(
              image: AssetImage('assets/image/G.png'),
              width: 300,
              height: 250,
            ),
          ),
        ],
      ),
    );
  }
}
