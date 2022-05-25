import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    Key? key,
  }) : super(key: key);
  late String otpCode;
  final GlobalKey _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
            key: _formkey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildIntroTexts(),
                  const SizedBox(
                    height: 110,
                  ),
                  _buildPhoneFormField(context),
                  const SizedBox(
                    height: 50,
                  ),
                  _buildNextButton(context),
                  _buildPhoneVerficationBloc(),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildIntroTexts() {
    return Column(
      children: [
        const Text(
          "What is your Number ? ",
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: const Text(
            "Please Enter your phone number !",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        )
      ],
    );
  }

  Widget _buildPhoneFormField(BuildContext context) {
    return Container(
      child: PinCodeTextField(
          autoFocus: true,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
              borderRadius: BorderRadius.circular(5),
              shape: PinCodeFieldShape.box,
              borderWidth: 1,
              fieldHeight: 50,
              fieldWidth: 40),
          onChanged: (v) {},
          animationType: AnimationType.scale,
          appContext: context,
          length: 6,
          onCompleted: (v) {
            otpCode = v;
          }),
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0.0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  void _login(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).submitOtp(otpCode);
  }

  Widget _buildPhoneVerficationBloc() {
    return BlocListener<AuthCubit, AuthState>(
      child: Container(),
      listener: (context, state) {
        // if (state is PhoneauthLoading) {
        //   return showProgressIndicator(context);
        // }
        var cubit = AuthCubit.get(context);
        if (state is OtpVerfied) {
          if (listOfUsersChoosedCategories
              .contains(cubit.instance.currentUser!.uid)) {
            Navigator.of(context).pushReplacementNamed(mainScreen);
          } else {
            Navigator.of(context).pushReplacementNamed(chossingCategoryScreen);
          }
        }
        if (state is PhoneauthError) {
          Navigator.pop(context);
          String error = state.error;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error),
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 3),
          ));
          if (error.contains("asso")) {
            print("true");
            Navigator.pushReplacementNamed(context, registerScreen);
          }
        }
        if (state is EmailauthError) {
          Navigator.pop(context);
          String error = state.error;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error),
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 3),
          ));
          if (error.contains("asso")) {
            print("true 2");
            Navigator.pushReplacementNamed(context, registerScreen);
          }
        }
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 50),
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () {
            // showProgressIndicator(context);
            _login(context);
          },
          child: const Text(
            "Verify",
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }
}
