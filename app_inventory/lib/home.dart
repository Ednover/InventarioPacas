import 'itemList.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final List<ItemList> entries = <ItemList>[
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
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(left: 10),
              width: double.infinity,
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
                child: Center(child: entries[index]),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Container(
                width: double.infinity,
                height: 10,
              ),
          itemCount: entries.length),
    );
  }
}
