import '../home/top_resume.dart';

import '../lists/home_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }  
}

class _Home extends State<Home> with SingleTickerProviderStateMixin{
  final List<ItemList> items = <ItemList>[
    ItemList(type: 'Vendidas', amount: 30),
    ItemList(type: 'Disponibles', amount: 20),
    ItemList(type: 'Clientes', amount: 20),
    ItemList(type: 'Movimientos', amount: 20),
    ItemList(type: 'Vendidas', amount: 30),
  ];

  AnimationController _controller;
  Animation _paddingAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 650),
      vsync: this,
    );

    _paddingAnimation = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 500, bottom: 15), 
      end: EdgeInsets.only(top: 15, bottom: 15),
    ).animate(_controller);

    _controller.forward();

    _controller.addListener(() {
      setState(() {
        
      });
      //print(_controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final listaOpciones = ListView.separated(
      padding:
          _paddingAnimation.value,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: items[index]);
      },
      separatorBuilder: (BuildContext context, int index) => Container(
        width: double.infinity,
        height: 10,
      ),
      itemCount: items.length,
    );

    final containerList = Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.28),
        clipBehavior: Clip.antiAlias,
        child: listaOpciones,
        decoration: BoxDecoration(
          color: Color(0xffefefef),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
              ),
        ),
      );

    return Stack(
      alignment: AlignmentDirectional.topCenter, 
      children: <Widget>[
          TopResume(),
          containerList,
      ],
    );
  }
}
