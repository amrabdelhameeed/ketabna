// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/models/request_model.dart';
import 'package:ketabna/core/widgets/space.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text("requested book gangOf4 pinding"),
              );
            },
            separatorBuilder: (context, index) {
              return VerticalSpace(value: 1);
            },
            itemCount: 5,
            shrinkWrap: true,
          ),
        );
      },
    );
  }
}
