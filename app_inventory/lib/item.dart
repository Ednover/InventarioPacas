import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Item extends StatefulWidget {
  var type;
  double amount;

  @override
  State<StatefulWidget> createState() {
    return _Item(this.type, this.amount);
  }
}

class _Item extends State<Item> {
  var type;
  double amount;

  _Item(this.type, this.amount);

  @override
  Widget build(BuildContext context) {
    final iconItem = Container(
      child: selectIcon(type),
    );

    final titleItem = Container(
      child: Text(type),
    );

    final amountItem = Container(
      child: Text(""),
    );
  }
}

Icon selectIcon(var type) {
  var icon;
  switch (type) {
    case "vendidas":
      icon = Icon(
        Icons.attach_money,
        color: Colors.green,
      );
      break;
    case "disponibles":
      icon = Icon(
        Icons.check_box,
        color: Colors.green,
      );
      break;
    case "movimientos":
      icon = Icon(
        Icons.sync_alt,
        color: Colors.black,
      );
      break;
    case "clientes":
      icon = Icon(
        Icons.account_circle,
        color: Colors.black,
      );
      break;
    default:
  }
  return icon;
}
