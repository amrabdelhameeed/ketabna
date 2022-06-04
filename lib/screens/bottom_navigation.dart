import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// void main() => runApp(MaterialApp(home: BottomNavBar()));
// blue navigation bar  Write by baly
class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  // new
  List<Widget> screenWidget= [
    // write screen widget
    // 1 Home Screen
    // 2 Search Screen
    // 3 Add Screen
    // 4 chat Screen
    // 5 Profile Screen
  ];
   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>  [
            Icon(Icons.home_outlined, size: 30 ,color: Colors.white),
            Icon(Icons.search_outlined, size: 30,color: Colors.white),
            Icon(Icons.add, size: 30,color: Colors.white),
            Icon(Icons.message, size: 30,color: Colors.white),
            Icon(Icons.perm_identity, size: 30,color: Colors.white),
          ],
          color: Colors.orangeAccent,
          // buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,

        ),
        // new
        // body : screenWidget[_page]
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                ElevatedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    final CurvedNavigationBarState? navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState?.setPage(1);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
