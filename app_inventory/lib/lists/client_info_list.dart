import 'package:app_inventory/home/cards/client_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classes/client.dart';
import '../classes_info/client_info.dart';

class ClientInfoList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ClientInfoList();
}

class _ClientInfoList extends State<ClientInfoList> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Clients')
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
                child: ClientCard(
                  client: new Client(
                    id: snapshot.data.docs[index].id,
                    name: snapshot.data.docs[index].get('name'),
                    lastName: snapshot.data.docs[index].get('last_name'),
                    locale: snapshot.data.docs[index].get('locale'),
                    phone: int.parse(snapshot.data.docs[index].get('phone').toString()),
                  ),
                  onTapWidget: ClientInfo(client: new Client(
                    id: snapshot.data.docs[index].id,
                    name: snapshot.data.docs[index].get('name'),
                    lastName: snapshot.data.docs[index].get('last_name'),
                    locale: snapshot.data.docs[index].get('locale'),
                    phone: int.parse(snapshot.data.docs[index].get('phone').toString()),
                    ),
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
      );
  }
}
