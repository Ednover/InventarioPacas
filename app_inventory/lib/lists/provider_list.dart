import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classes/provider.dart';
import '../home/cards/provider_card.dart';

class ProviderList extends StatefulWidget {
  @override
  _ProviderList createState() => _ProviderList();
}

class _ProviderList extends State<ProviderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefefef),
      appBar: AppBar(
        title: Text("Proveedores"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('Providers').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.separated(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: ProviderCard(
                    provider: new Provider(
                      id: snapshot.data.docs[index].id,
                      name: snapshot.data.docs[index].get('name'),
                      locale: snapshot.data.docs[index].get('locale'),
                      phone: int.parse(
                          snapshot.data.docs[index].get('phone').toString()),
                      balance:
                          snapshot.data.docs[index].get('balance').toDouble(),
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
          }),
    );
  }
}
