import 'package:app_inventory/lists/client_list.dart';
import 'package:flutter/material.dart';

class PacaSale extends StatefulWidget {
  @override
  State<PacaSale> createState() => _PacaSale();
}

class _PacaSale extends State<PacaSale> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 55),
          child: ClientList(),
        ),
        Container(
          child: Text(
            "Elige el cliente a quien va a vender",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 60,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}