import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/screens/profile.dart';

import '../app_router.dart';
import '../core/models/user_model.dart';
import '../features/home/home_screen.dart';
import '../features/home/widgets/add_book.dart';
import '../features/search/search_screen.dart';

// void main() => runApp(MaterialApp(home: BottomNavBar()));
// blue navigation bar  Write by baly
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                index: cubit.curIndex,
                height: 60.0,
                items: const <Widget>[
                  Icon(Icons.home_outlined, size: 30, color: Colors.white),
                  Icon(Icons.search_outlined, size: 30, color: Colors.white),
                  Icon(Icons.add, size: 30, color: Colors.white),
                  Icon(Icons.message, size: 30, color: Colors.white),
                  Icon(Icons.perm_identity, size: 30, color: Colors.white),
                ],
                color: Colors.orangeAccent,
                // buttonBackgroundColor: Colors.black,
                backgroundColor: const Color(0xFFF5F1D7),
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 600),
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                letIndexChange: (index) => true,
              ),
              body: cubit.screenWidget[cubit.curIndex]);
        });
  }
}
