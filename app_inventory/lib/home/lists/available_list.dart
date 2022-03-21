import 'package:flutter/material.dart';

import '../../classes/paca.dart';
import '../cards/paca_card.dart';

class AvailableList extends StatefulWidget {

  @override
  _AvailableList createState() => _AvailableList();
}

class _AvailableList extends State<AvailableList> {

    final List<PacaCard> pacas = <PacaCard>[
    PacaCard(paca: new Paca(name: 'Niño mixto', amount: 0, price: 3000, provider: "",)),
    PacaCard(paca: new Paca(name: 'Hombre', amount: 0, price: 5000, provider: "",)),
    PacaCard(paca: new Paca(name: 'Mujer', amount: 0, price: 2000, provider: "",)),
    PacaCard(paca: new Paca(name: 'Deportivo mixto', amount: 0, price: 7000, provider: "",)),
    PacaCard(paca: new Paca(name: 'Ropa interior mixto', amount: 0, price: 6000, provider: "",)),
    PacaCard(paca: new Paca(name: 'Shorts y cargo', amount: 0, price: 5500, provider: "",)),
    PacaCard(paca: new Paca(name: 'Hombre mixto', amount: 0, price: 5500, provider: "",)),
    PacaCard(paca: new Paca(name: 'Mujer mixto', amount: 0, price: 5500, provider: "",)),
    PacaCard(paca: new Paca(name: 'Deportivo hombre', amount: 0, price: 5500, provider: "",)),
    PacaCard(paca: new Paca(name: 'Deportivo mujer', amount: 0, price: 5500, provider: "",)),
    PacaCard(paca: new Paca(name: 'Ropa invierno', amount: 0, price: 5500, provider: "",)),
    PacaCard(paca: new Paca(name: 'Ropa playa', amount: 0, price: 5500, provider: "",)),
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
