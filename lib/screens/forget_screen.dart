// Write by BALY
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ketabna/core/utils/app_colors.dart';
import 'package:ketabna/core/widgets/components.dart';

import '../core/widgets/default_form_button.dart';
import '../core/widgets/default_text_form_field.dart';

class ForgetScreen extends StatelessWidget {
  ForgetScreen({Key? key}) : super(key: key);
  getHeight({context}) {
    final height = MediaQuery.of(context).size.height;
    return height;
  }

  getWidth({context}) {
    final width = MediaQuery.of(context).size.width;
    return width;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppColors.secondaryColor,
          size: 32,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: getHeight(context: context) / 5,
                ),
                Text(
                  "Forget Password !",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getHeight(context: context) / 25,
                ),
                Text(
                  'We will send you message via your email ',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: getHeight(context: context) / 50,
                ),
                DefaultTextFormField(
                  hint: 'Enter email address',
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                  validationText: 'please enter valid email',
                  radius: 15,
                ),
                SizedBox(
                  height: getHeight(context: context) / 25,
                ),
                DefaultFormButton(
                  text: 'Send',
                  textColor: Colors.white,
                  fontSize: 20,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final email = emailController.value.text;
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email)
                          .then((value) => {
                                emailController.clear(),
                                buildSnackBar(
                                    context: context,
                                    text: 'Check your email.',
                                    color: Colors.green)
                              })
                          .onError((error, stackTrace) => {
                                buildSnackBar(
                                    context: context,
                                    text: error.toString(),
                                    color: Colors.red)
                              });
                    }
                  },
                  fillColor: AppColors.secondaryColor,
                  radius: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
