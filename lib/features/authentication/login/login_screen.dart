import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/widgets/mytextformfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogedInSuccessState) {
          Navigator.pushReplacementNamed(context, mainScreen);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              left: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: textStyleBig,
                ),
                const SizedBox(
                  height: 20,
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
                  hintText: "Phone",
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      cubit.loginWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text);
                    },
                    child: const Text("Login")),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Expanded(
                        flex: 4, child: Text("U don't have account ?")),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, registerScreen);
                            },
                            child: const Text(
                              "Register Now",
                              style: TextStyle(color: Colors.blue),
                            ))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
