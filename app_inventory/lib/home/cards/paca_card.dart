import 'package:flutter/material.dart';

import '../../classes/paca.dart';
import '../../classes_info/paca_info.dart';

class PacaCard extends StatefulWidget {
  final Paca paca;

  PacaCard({@required this.paca}) : super();

  @override
  State<PacaCard> createState() => _PacaCard();
}

class _PacaCard extends State<PacaCard> {
  @override
  Widget build(BuildContext context) {
    final namePaca = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.paca.getName(),
        style: TextStyle(fontSize: 20),
      ),
      alignment: Alignment.centerLeft,
    );

    final pricePaca = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.paca.getPrice().toString(),
        style: TextStyle(fontSize: 16),
      ),
      alignment: Alignment.topLeft,
    );

    final paca = Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Se presionó el boton de " + widget.paca.getName()),
          ));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                    PacaInfo(paca: widget.paca,),
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
                  Expanded(flex: 6, child: namePaca),
                  Expanded(flex: 4, child: pricePaca)
                ],
              )
            ],
          ),
        ),
      ),
    );
    return paca;
  }
}