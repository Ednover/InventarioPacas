import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          child: IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
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
