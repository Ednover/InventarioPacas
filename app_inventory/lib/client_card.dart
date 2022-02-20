import 'package:flutter/material.dart';

class Client extends StatefulWidget {
  final String name;
  final double amount;

  Client({@required this.name, this.amount}) : super();

  @override
  State<StatefulWidget> createState() {
    return _Client();
  }
}

class _Client extends State<Client> {
  @override
  Widget build(BuildContext context) {
    final nameClient = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.name,
        style: TextStyle(fontSize: 20),
      ),
      alignment: Alignment.centerLeft,
    );

    final amountClient = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.amount.toString(),
        style: TextStyle(fontSize: 16),
      ),
      alignment: Alignment.topLeft,
    );

    final client = Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Se presionó el boton de " + widget.name),
          ));
          Navigator.push(
              context,
              MaterialPageRoute(
                  //builder: (context) => selectRoute(widget.type),
                  ));
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
