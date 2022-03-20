import 'package:app_inventory/home/cards/client_card.dart';
import 'package:flutter/material.dart';

class ClientList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClientList();
}

class _ClientList extends State<ClientList> {
  final List<Client> clients = <Client>[
    Client(name: 'Mario', amount: 20),
    Client(name: 'Ana', amount: 20),
    Client(name: 'Pedro', amount: 20),
    Client(name: 'Karla', amount: 20),
    Client(name: 'Luis', amount: 20),
    Client(name: 'Eduardo', amount: 20),
    Client(name: 'Alfredo', amount: 20),
    Client(name: 'Abel', amount: 20),
    Client(name: 'Veronica', amount: 20),
    Client(name: 'Jesus', amount: 20),
    Client(name: 'Miguel', amount: 20),
    Client(name: 'David', amount: 20),
    Client(name: 'Daniel', amount: 20),
    Client(name: 'Jose', amount: 20),
    Client(name: 'Alberto', amount: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: clients[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) => Container(
          width: double.infinity,
          height: 10,
        ),
        itemCount: clients.length,
      ),
    );
  }
}
