import 'package:flutter/material.dart';

import '../../classes/provider.dart';
import '../../classes_info/provider_info.dart';
import '../../forms/provider_payment.dart';

class ProviderCard extends StatefulWidget {
  final Provider provider;

  ProviderCard({@required this.provider}) : super();

  @override
  _ProviderCard createState() => _ProviderCard();
}

class _ProviderCard extends State<ProviderCard> {
  @override
  Widget build(BuildContext context) {
    final nameProvider = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.provider.getName(),
        style: TextStyle(fontSize: 22),
      ),
      alignment: Alignment.centerLeft,
    );

    final localeProvider = Container(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        widget.provider.getLocale(),
        style: TextStyle(fontSize: 18),
      ),
      alignment: Alignment.topLeft,
    );

    final provider = Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderInfo(provider: widget.provider),
              ));
        },
        onLongPress: () {},
        child: Ink(
          padding: EdgeInsets.only(left: 10, right: 5),
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
                  Expanded(flex: 6, child: nameProvider),
                  Expanded(flex: 4, child: localeProvider),
                ],
              ),
              IconButton(
                iconSize: 50,
                icon: const Icon(Icons.attach_money),
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProviderPayment(provider: widget.provider),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
    return provider;
  }
}
