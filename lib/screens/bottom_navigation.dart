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
class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;


  List<Widget> screenWidget= [
    // write screen widget
    /* 1 Home Screen */ BlocProvider<AuthCubit>.value(
  value: authCubit!
  ..getCurrentFirestoreUser()
  ..getRecommended()
  ..getHorrorBooks()
  ..getTechnologyBooks()
  ..getFantasyBooks()
  ..getnovelBooks()
  ..getfictionBooks()
  ..getbiographyBooks(),
  child: HomeScreen(),
  ),
    /* 2 Search Screen*/SearchScreen(searchBy: '',),
    /* 3 Add Screen*/AddBook(),
    /* 4 chat Screen*/AddBook(),
    /* 5 Profile Screen*/ BlocProvider<AuthCubit>.value(
  value: authCubit!..getUserBooks(),
  child: ProfileScreen(),
  ),
  ];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.home_outlined, size: 30 ,color: Colors.white),
            Icon(Icons.search_outlined, size: 30,color: Colors.white),
            Icon(Icons.add, size: 30,color: Colors.white),
            Icon(Icons.message, size: 30,color: Colors.white),
            Icon(Icons.perm_identity, size: 30,color: Colors.white),
          ],
          color: Colors.orangeAccent,
          // buttonBackgroundColor: Colors.black,
          backgroundColor: Color(0xFFF5F1D7),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body : screenWidget[_page]
        // body: Container(
        //   color: Colors.white,
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         Text(_page.toString(), textScaleFactor: 10.0),
        //         ElevatedButton(
        //           child: const Text('Go To Page of index 1'),
        //           onPressed: () {
        //             final CurvedNavigationBarState? navBarState =
        //                 _bottomNavigationKey.currentState;
        //             navBarState?.setPage(1);
        //           },
        //         )
        //       ],
        //     ),
        //   ),
        // ));
    );
  }
}
