import 'package:app_inventory/classes_info/client_info.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatefulWidget {
  final String name;
  final double amount;

  ClientCard({@required this.name, this.amount}) : super();

  @override
  State<StatefulWidget> createState() => _Client();
}

class _Client extends State<ClientCard> {
  @override
  Widget build(BuildContext context) {
    final nameClient = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.name,
        style: TextStyle(fontSize: 22),
      ),
      alignment: Alignment.centerLeft,
    );

    final amountClient = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.amount.toString(),
        style: TextStyle(fontSize: 18),
      ),
      alignment: Alignment.topLeft,
    );

    final client = Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                ClientInfo(name: widget.name, amount: widget.amount),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: nameClient),
                  Expanded(flex: 4, child: amountClient)
                ],
              )
            ],
          ),
        ),
      ),
    );
    return client;
  }
}
