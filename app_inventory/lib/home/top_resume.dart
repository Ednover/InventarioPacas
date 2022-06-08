import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopResume extends StatefulWidget {
  @override
  _TopResume createState() => _TopResume();
}

class _TopResume extends State<TopResume> {
  double totalInputs = 0;
  double totalOutputs = 0;
  double totalBalanceProviders = 0;
  double totalBalanceClients = 0;

  Future<void> queryInputsPacas() async {
    await FirebaseFirestore.instance
        .collection('Inputs')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        totalOutputs += double.parse(doc['total'].toString());
      });
    });
  }

  Future<void> queryOutputsPacas() async {
    await FirebaseFirestore.instance
        .collection('Outputs')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        totalInputs += double.parse(doc['total'].toString());
      });
    });
  }

  Future<void> queryBalanceProviders() async {
    await FirebaseFirestore.instance
        .collection('Providers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        totalBalanceProviders += double.parse(doc['balance'].toString());
      });
    });
  }

  Future<void> queryBalanceClients() async {
    await FirebaseFirestore.instance
        .collection('Clients')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        totalBalanceClients += double.parse(doc['balance'].toString());
      });
    });
  }

  void getConsults() async {
    await queryInputsPacas();
    await queryOutputsPacas();
    await queryBalanceProviders();
    await queryBalanceClients();
    setState(() {});
  }

  void initState() {
    super.initState();
    getConsults();
  }

  @override
  Widget build(BuildContext context) {
    final background = Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
    );

    var inputs = Column(
      children: [
        Text(
          "Ingresos",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "\$$totalInputs",
          style: TextStyle(
            color: Color.fromARGB(255, 80, 242, 22),
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );

    var outputs = Column(
      children: [
        Text(
          "Egresos",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "\$$totalOutputs",
          style: TextStyle(
            color: Color.fromARGB(255, 250, 93, 84),
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );

    var balanceProviders = Column(
      children: [
        Text(
          "Balance\nproveedores",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "\$$totalBalanceProviders",
          style: TextStyle(
            color: Color.fromARGB(255, 250, 93, 84),
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );

    var balanceClients = Column(
      children: [
        Text(
          "Balance\nclientes",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "\$$totalBalanceClients",
          style: TextStyle(
            color: Color.fromARGB(255, 80, 242, 22),
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );

    final texts = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              outputs,
              Divider(height: 0, thickness: 2),
              balanceProviders,
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              inputs,
              Divider(height: 0, thickness: 2),
              balanceClients,
            ],
          ),
        ),
      ],
    );

    return Stack(
      children: <Widget>[
        background,
        //Positioned(width: MediaQuery.of(context).size.width, top: 70, child: texts),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 230,
          child: texts,
        ),
      ],
    );
  }
}
