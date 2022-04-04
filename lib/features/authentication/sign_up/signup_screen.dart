import 'package:flutter/material.dart';
import 'package:ketabna/core/constants/constants.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/utils/app_colors.dart';
import 'package:ketabna/core/widgets/default_check_box.dart';
import 'package:ketabna/core/widgets/default_form_button.dart';
import 'package:ketabna/core/widgets/default_text_form_field.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            padding: EdgeInsets.only(top: 20.0),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushReplacementNamed(context, loginScreen);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.secondaryColor,
              size: 22.0,
            ),
          ),
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
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF242126),
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SFPro',
                        ),
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'First & Last Name',
                        controller: _nameController,
                        validationText: 'First & Last Name can\'t be empty.',
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
                        hint: 'Mobile Phone',
                        controller: _mobileController,
                        inputType: TextInputType.phone,
                        validationText: 'Mobile Phone can\'t be empty.',
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                        validationText: 'Password can\'t be empty.',
                      ),
                      formVerticalDistance,
                      DefaultTextFormField(
                        hint: 'Confirm Password',
                        controller: _confirmPasswordController,
                        isPassword: true,
                        validationText: 'Confirm Password can\'t be empty.',
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const DefaultCheckBox(
                        checkInfo: 'accept term & conditions',
                      ),
                      const DefaultCheckBox(checkInfo: 'Using What\'s app'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DefaultFormButton(
                        onPressed: () {
                          formKey.currentState!.validate();
                        },
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}
