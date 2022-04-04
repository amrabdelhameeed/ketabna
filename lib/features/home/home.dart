import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/widgets/custom_general_button.dart';
import 'package:ketabna/core/widgets/mytextformfield.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // var cubit = BlocProvider.of<AuthCubit>(context);

        // if (state is GetBooksSuccessState) {
        //   cubit.getUserS();
        // }
        // if (state is GetUserByUidState) {
        //   print(state.userModel.phone);
        // }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthCubit>(context);
        return Scaffold(
          body: Column(
            children: [
              Center(
                child: CustomGeneralButton(
                  callback: () {
                    BlocProvider.of<AuthCubit>(context).logOut().then((value) {
                      Navigator.pushReplacementNamed(context, registerScreen);
                    });
                  },
                  text: "SignOut",
                ),
              ),
              Center(
                child: CustomGeneralButton(
                  callback: () {
                    print(cubit.getLoggedInUser().phoneNumber);
                  },
                  text: "SignOut",
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text("${cubit.getLoggedInUser().email}"),
                    Text("${cubit.getLoggedInUser().displayName}"),
                    Text("${cubit.getLoggedInUser().phoneNumber}"),
                    MyTextFormField(
                      controller: textEditingController,
                      hintText: "set category",
                    ),
                    CustomGeneralButton(
                      text: "5raaaaaaa",
                      callback: () {
                        cubit.getAllBooksByCategory(
                            category: textEditingController.text);
                      },
                    ),
                    CustomGeneralButton(
                      text: "set data",
                      callback: () {
                        cubit.addBook(
                          category: textEditingController.text,
                          authorName: "hamada",
                          nameAr: "جانج اوف فور",
                          nameEn: "grokking algorithms",
                          picture: "",
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
