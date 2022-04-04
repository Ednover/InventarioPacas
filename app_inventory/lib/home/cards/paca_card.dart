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
        style: TextStyle(fontSize: 22),
      ),
      alignment: Alignment.centerLeft,
    );

    final pricePaca = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.paca.getPrice().toString(),
        style: TextStyle(fontSize: 18),
      ),
      alignment: Alignment.topLeft,
    );

    final amountPaca = Container(
      padding: const EdgeInsets.only(right: 20),
      child: Text(
        widget.paca.getAmount().toString(),
        style: TextStyle(fontSize: 32),
      ),
      alignment: Alignment.center,
    );

    final paca = Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                PacaInfo(paca: widget.paca,),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: namePaca),
                  Expanded(flex: 4, child: pricePaca)
                ],
              ),
              amountPaca,
            ],
          ),
        ),
      ),
    );
    return paca;
  }
}