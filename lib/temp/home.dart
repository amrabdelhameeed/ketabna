// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/app_router.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/constants.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/utils/size_config.dart';
import 'package:ketabna/core/widgets/space.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  TextEditingController textEditingController = TextEditingController();
  List<BookModel> localBooks = [];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider<AuthCubit>.value(
      value: authCubit!..getRecommended(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
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
                localBooks.isNotEmpty
                    ? SizedBox(
                        height: 130,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return HorizontalSpace(
                              value: 1,
                            );
                          },
                          itemBuilder: (context, index) {
                            return localBooks[index].picture != null
                                ? InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, bookScreen,
                                          arguments: localBooks[index]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          image: DecorationImage(
                                              image: NetworkImage(''))),
                                      height: 120,
                                      child: Column(
                                        children: [
                                          Text(localBooks[index].authorName!),
                                          Text(localBooks[index].name!),
                                          Text(localBooks[index].bookId!)
                                        ],
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: localBooks.length,
                        ),
                      )
                    : Center(
                        child: Text("laaaaaaaaa"),
                      ),
                VerticalSpace(value: 1),
                ElevatedButton(
                    onPressed: () {
                      cubit.addBook(
                          describtion: '',
                          category: "technologyInterst",
                          name: "قران",
                          bookLink: '',
                          authorName: "-");
                    },
                    child: Text("pick photo and add book"))
              ],
            ),
          );
        },
      ),
    );
  }
}
