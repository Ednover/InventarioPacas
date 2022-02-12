import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add.dart';
import 'buttons.dart';

class NavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationBar();
  }
}

class _NavigationBar extends State<NavigationBar> {
  int indexTap = 1;
  final List<Widget> widgetsChildren = [Add(), Buttons(), Add()];
  void onTapTapped(int index) {
    setState(() {
      indexTap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetsChildren[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Colors.white, primaryColor: Colors.blue),
        child: BottomNavigationBar(
          onTap: onTapTapped,
          currentIndex: indexTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_shopping_cart,
                size: 30,
              ),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              title: Text("Inicio"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_money,
                size: 30,
              ),
              title: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}
