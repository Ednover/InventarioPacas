import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add.dart';
import 'buttons.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Menu();
  }
}

class _Menu extends State<Menu> {
  int indexTap = 1;
  var titleBar = "Inventario";
  final List<Widget> widgetsChildren = [Add(), Buttons(), Add()];
  void onTapTapped(int index) {
    setState(() {
      indexTap = index;
      switch (index) {
        case 0:
          titleBar = "Registro";
          break;
        case 1:
          titleBar = "Inventario";
          break;
        case 2:
          titleBar = "Venta";
          break;
        default:
          titleBar = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.dehaze),
          onPressed: () {},
        ),
        title: Text(titleBar),
        centerTitle: true,
      ),
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
              label: "Registro",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: "Inicio",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_money,
                size: 30,
              ),
              label: "Venta",
            ),
          ],
        ),
      ),
    );
  }
}
