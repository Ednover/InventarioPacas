import 'package:app_inventory/home/cards/client_card.dart';
import 'package:flutter/material.dart';

class ClientList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClientList();
}

class _ClientList extends State<ClientList>{

  final List<ClientCard> clients = <ClientCard>[
    ClientCard(name: 'Mario', amount: 20),
    ClientCard(name: 'Ana', amount: 20),
    ClientCard(name: 'Pedro', amount: 20),
    ClientCard(name: 'Karla', amount: 20),
    ClientCard(name: 'Luis', amount: 20),
    ClientCard(name: 'Eduardo', amount: 20),
    ClientCard(name: 'Alfredo', amount: 20),
    ClientCard(name: 'Abel', amount: 20),
    ClientCard(name: 'Veronica', amount: 20),
    ClientCard(name: 'Jesus', amount: 20),
    ClientCard(name: 'Miguel', amount: 20),
    ClientCard(name: 'David', amount: 20),
    ClientCard(name: 'Daniel', amount: 20),
    ClientCard(name: 'Jose', amount: 20),
    ClientCard(name: 'Alberto', amount: 20),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: ListView.separated(
      padding:
          EdgeInsets.only(top: 15, bottom: 15),
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
