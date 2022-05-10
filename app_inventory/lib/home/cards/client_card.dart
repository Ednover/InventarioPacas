import 'package:flutter/material.dart';

import '../../classes/client.dart';

class ClientCard extends StatefulWidget {
  final Client client;
  final Widget onTapWidget;

  ClientCard({@required this.client, this.onTapWidget}) : super();

  @override
  State<StatefulWidget> createState() => _Client();
}

class _Client extends State<ClientCard> {
  @override
  Widget build(BuildContext context) {
    final nameClient = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.client.getName(),
        style: TextStyle(fontSize: 22),
      ),
      alignment: Alignment.centerLeft,
    );

    final localeClient = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.client.getLocale(),
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
                widget.onTapWidget,
            )
          );
        },
        onLongPress: (){},
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
                  Expanded(flex: 4, child: localeClient)
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
