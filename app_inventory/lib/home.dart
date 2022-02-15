import 'package:app_inventory/topResume.dart';

import 'itemList.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final List<ItemList> items = <ItemList>[
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Disponibles', amount: 20),
    ItemList(type: 'Movimientos', amount: 20),
    ItemList(type: 'Clientes', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
    ItemList(type: 'Vendidas', amount: 20),
  ];

  @override
  Widget build(BuildContext context) {
    final listaOpciones = ListView.separated(
      padding:
          EdgeInsets.only(top: 15, bottom: 15),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black.withAlpha(30),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {},
            child: Center(child: items[index]),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(
        width: double.infinity,
        height: 10,
      ),
      itemCount: items.length,
    );

    final backgroundList = Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.28),
        clipBehavior: Clip.antiAlias,
        child: listaOpciones,
        decoration: BoxDecoration(
          color: Color(0xffefef1ef),
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
          backgroundList,
      ],
    );
  }
}
