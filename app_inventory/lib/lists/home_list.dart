import 'package:app_inventory/home/lists/available_list.dart';
import 'package:app_inventory/home/lists/sold_list.dart';
import 'package:flutter/material.dart';

import 'client_list.dart';

class ItemList extends StatefulWidget {
  final String type;
  final double amount;

  ItemList({@required this.type, this.amount}) : super();

  @override
  State<StatefulWidget> createState() {
    return _ItemList();
  }
}

class _ItemList extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final iconItem = Container(
      child: selectIcon(widget.type),
    );

    final titleItem = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.type,
        style: TextStyle(fontSize: 20),
      ),
      alignment: Alignment.centerLeft,
    );

    final amountItem = Container(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        widget.amount.toString(),
        style: TextStyle(fontSize: 16),
      ),
      alignment: Alignment.topLeft,
    );

    final item = Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => 
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Clientes"),
              ),
              backgroundColor: Color(0xffefefef),
              body: selectRoute(widget.type),
            ),
          )
        );
      },
      child: Ink(
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
        child: Row(
          children: <Widget>[
            iconItem,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: titleItem),
                Expanded(flex: 4, child: amountItem)
              ],
            )
          ],
        ),
      ),
    ));

    return item;
  }
}

Icon selectIcon(var type) {
  var icon;
  switch (type) {
    case "Vendidas":
      icon = Icon(
        Icons.attach_money,
        color: Colors.green,
        size: 50,
      );
      break;
    case "Disponibles":
      icon = Icon(
        Icons.check_box,
        color: Colors.green,
        size: 50,
      );
      break;
    case "Movimientos":
      icon = Icon(
        Icons.sync_alt,
        color: Colors.black,
        size: 50,
      );
      break;
    case "Clientes":
      icon = Icon(
        Icons.account_circle,
        color: Colors.black,
        size: 50,
      );
      break;
    default:
  }
  return icon;
}

Widget selectRoute(var type) {
    Widget route;
    switch (type) {
    case "Vendidas":
      route = SoldList();
      break;
    case "Disponibles":
      route = AvailableList();
      break;
    case "Movimientos":
      
      break;
    case "Clientes":
      route = ClientList();
      break;
    default:
  }
  return route;
  }
