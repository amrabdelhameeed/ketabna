import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/widgets/custom_general_button.dart';
import 'package:ketabna/core/widgets/mytextformfield.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String location = "Cairo";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PhoneNumberSubmitted) {
          Navigator.pushNamed(context, otpscreen);
        }
        if (state is PhoneauthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error : ${state.error}")));
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              left: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cubit.isTechnical
                      ? "Register as Technical"
                      : "Register as client",
                  style: textStyleBig,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  controller: nameController,
                  hintText: "name",
                ),
                MyTextFormField(
                  controller: emailController,
                  hintText: "email",
                ),
                MyTextFormField(
                  controller: passController,
                  hintText: "password",
                ),
                MyTextFormField(
                  controller: phoneController,
                  hintText: "phone",
                ),
                Row(
                  children: [
                    const Expanded(
                        flex: 4, child: Text("U already have account ?")),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, loginScreen);
                            },
                            child: const Text(
                              "Login Now",
                              style: TextStyle(color: Colors.blue),
                            ))),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomGeneralButton(
                  callback: () {
                    cubit.signUpWithEmailAndPassword(
                        fantasyInterst: true,
                        fictionInterst: true,
                        horrorInterst: false,
                        novelInterst: false,
                        studingInterst: true,
                        technologyInterst: true,
                        email: emailController.text,
                        intersts: "no",
                        name: nameController.text,
                        password: passController.text,
                        phone: phoneController.text);
                  },
                  text: "Sign Up",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
