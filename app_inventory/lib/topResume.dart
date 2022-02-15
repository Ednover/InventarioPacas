import 'package:flutter/material.dart';

class TopResume extends StatelessWidget {
  final ganacias = 2000;
  final gastos = 1300;

  @override
  Widget build(BuildContext context) {
    final background = Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
    );  

    final texts = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "\$$ganacias",
          style: TextStyle(
            color: Color.fromARGB(255, 95, 214, 101),
            fontSize: 40,
          )
        ),
        Text(
          "\$$gastos",
          style: TextStyle(
            color: Color.fromARGB(255, 212, 111, 103),
            fontSize: 40,
          ),
        ),
      ],
    ); 

    return Stack( 
      children: <Widget>[
        background,
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: 70,
          child: texts
        ),
    ],
    );
  }
}