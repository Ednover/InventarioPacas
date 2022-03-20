import 'package:flutter/material.dart';

import '../cards/paca_card.dart';

class SoldList extends StatefulWidget {
  @override
  _SoldList createState() => _SoldList();
}

class _SoldList extends State<SoldList> {
  final List<PacaCard> pacas = <PacaCard>[
    PacaCard(name: 'Niño mixto', price: 3000),
    PacaCard(name: 'Hombre', price: 5000),
    PacaCard(name: 'Mujer', price: 2000),
    PacaCard(name: 'Deportivo mixto', price: 7000),
    PacaCard(name: 'Ropa interior mixto', price: 6000),
    PacaCard(name: 'Shots y cargo', price: 5500),
    PacaCard(name: 'Hombre mixto', price: 5500),
    PacaCard(name: 'Mujer mixto', price: 5500),
    PacaCard(name: 'Deportivo hombre', price: 5500),
    PacaCard(name: 'Deportivo mujer', price: 5500),
    PacaCard(name: 'Ropa invierno', price: 5500),
    PacaCard(name: 'Ropa playa', price: 5500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacas vendidas'),
      ),
      body: ListView.separated(
      padding:
          EdgeInsets.only(top: 15, bottom: 15),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: pacas[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(
        width: double.infinity,
        height: 10,
      ),
      itemCount: pacas.length,
    ),
    );
  }
}