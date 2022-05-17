import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/default_check_box.dart';
import '../../../core/widgets/default_form_button.dart';
import '../../../core/widgets/default_text_form_field.dart';

class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // leading: IconButton(
          //   padding: EdgeInsets.only(top: 20.0),
          //   onPressed: () {
          //     Navigator.pop(context);
          //     // Navigator.pushReplacementNamed(context, loginScreen);
          //   },
          //   icon: const Icon(
          //     Icons.arrow_back_ios_new,
          //     color: AppColors.secondaryColor,
          //     size: 22.0,
          //   ),
          // ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xFF242126),
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SFPro',
                        ),
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'Email Address',
                        controller: _emailController,
                        inputType: TextInputType.emailAddress,
                        validationText: 'Email Address can\'t be empty.',
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                        validationText: 'Password can\'t be empty.',
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const DefaultCheckBox(
                            checkInfo: 'Stay Logged In',
                          ),
                          TextButton(
                              onPressed: () {
                                // here you will push the forgotten password screen
                              },
                              child: const Text('Forgotten Password?',
                                  style: TextStyle(
                                    color: AppColors.formFontColor,
                                    fontFamily: 'SFPro',
                                    fontWeight: FontWeight.w400,
                                  )))
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is LogedInSuccessState) {
                            Navigator.pushReplacementNamed(context, mainScreen);
                          }
                        },
                        builder: (context, state) {
                          var cubit = AuthCubit.get(context);
                          return DefaultFormButton(
                            text: 'Sign In',
                            fillColor: AppColors.secondaryColor,
                            textColor: Colors.white,
                            fontSize: 19.0,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.loginWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}
