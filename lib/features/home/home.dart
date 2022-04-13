// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/app_router.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/constants.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/utils/size_config.dart';
import 'package:ketabna/core/widgets/custom_general_button.dart';
import 'package:ketabna/core/widgets/mytextformfield.dart';
import 'package:ketabna/core/widgets/space.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider<AuthCubit>.value(
      value: authCubit!..getRecommended(),
      child: BlocConsumer<AuthCubit, AuthState>(
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
            appBar: AppBar(actions: [
              IconButton(
                  onPressed: () {
                    cubit.logOut().then((value) {
                      Navigator.pushReplacementNamed(context, registerScreen);
                    });
                  },
                  icon: Icon(Icons.exit_to_app))
            ]),
            body: Column(
              children: [
                Text(
                  "Recommended",
                  style: textStyleBig,
                ),
                VerticalSpace(
                  value: 2,
                ),
                state is GetRecommended
                    ? SizedBox(
                        height: 130,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return HorizontalSpace(
                              value: 1,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              height: 120,
                              color: Colors.grey.shade300,
                              child: Column(
                                children: [
                                  Text(state.books[index].authorName!),
                                  Text(state.books[index].nameAr!),
                                  Text(state.books[index].bookId!)
                                ],
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: state.books.length,
                        ),
                      )
                    : Center(
                        child: Text("laaaaaaaaa"),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
