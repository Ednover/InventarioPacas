import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dialog_add_cart.dart';
import 'paca.dart';

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Ink(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: DialogRegistro(),
        ),
        Expanded(
          child: ListView(
            children: [
              Text('Hola'),
            ],
          ),
        ),
      ],
    );
  }
}
