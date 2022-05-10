import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../classes/paca.dart';
import '../cards/paca_card.dart';

class AvailableList extends StatefulWidget {
  @override
  _AvailableList createState() => _AvailableList();
}

class _AvailableList extends State<AvailableList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacas vendidas'),
      ),
      backgroundColor: Color(0xffefefef),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Inventory')
            .where('amount', isGreaterThan: 0)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView.separated(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: PacaCard(
                  paca: new Paca(
                    name: snapshot.data.docs[index].get('name'),
                    amount: snapshot.data.docs[index].get('amount').toInt(),
                    price: snapshot.data.docs[index].get('price').toDouble(),
                    provider: snapshot.data.docs[index].get('provider'),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Container(
              width: double.infinity,
              height: 10,
            ),
            itemCount: snapshot.data.docs.length,
          );
        }
      ),
    );
  }
}
