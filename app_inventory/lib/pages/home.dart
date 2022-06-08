import 'package:cloud_firestore/cloud_firestore.dart';

import '../home/top_resume.dart';

import '../lists/home_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  List<ItemList> items = <ItemList>[];

  AnimationController _controller;
  Animation _paddingAnimation;
  int totalAvaible = 0;
  int totalClients = 0;
  int totalProviders = 0;

  bool isLoading = false;

  Future<void> queryAmountPacas() async {
    await FirebaseFirestore.instance
        .collection('Inventory')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        totalAvaible += int.parse(doc['amount'].toString());
      });
    }).catchError((error) => print("Failed to add user: $error"));
    return null;
  }

  Future<void> queryAmountClients() async {
    await FirebaseFirestore.instance
        .collection('Clients')
        .get()
        .then((QuerySnapshot querySnapshot) {
      totalClients = querySnapshot.docs.length;
    }).catchError((error) => print("Failed to query clients: $error"));
    return null;
  }

  Future<void> queryAmountProviders() async {
    await FirebaseFirestore.instance
        .collection('Providers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      totalProviders = querySnapshot.docs.length;
    }).catchError((error) => print("Failed to query providers: $error"));
    return null;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 650),
      vsync: this,
    );

    _paddingAnimation = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 500, bottom: 15),
      end: EdgeInsets.only(top: 15, bottom: 15),
    ).animate(_controller);

    refreshItems();
  }

  void animationInit() {
    _controller.forward();

    _controller.addListener(() {
      setState(() {});
      //print(_controller.value);
    });
  }

  void refreshItems() async {
    setState(() {
      isLoading = true;
    });
    await queryAmountPacas();
    await queryAmountClients();
    await queryAmountProviders();
    setState(() {
      items.add(
        ItemList(type: 'Vendidas', amount: 0),
      );
      items.add(
        ItemList(type: 'Disponibles', amount: totalAvaible),
      );
      items.add(
        ItemList(type: 'Clientes', amount: totalClients),
      );
      items.add(
        ItemList(
          type: 'Proveedores',
          amount: totalProviders,
        ),
      );
      items.add(
        ItemList(type: 'Movimientos', amount: 0),
      );
    });
    setState(() {
      isLoading = false;
    });
    animationInit();
  }

  @override
  Widget build(BuildContext context) {
    final listaOpciones = ListView.separated(
      padding: _paddingAnimation.value,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: EdgeInsets.only(left: 10, right: 10), child: items[index]);
      },
      separatorBuilder: (BuildContext context, int index) => Container(
        width: double.infinity,
        height: 10,
      ),
      itemCount: items.length,
    );

    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        TopResume(),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.28),
          clipBehavior: Clip.antiAlias,
          child: (!isLoading)
              ? listaOpciones
              : Center(child: CircularProgressIndicator()),
          decoration: BoxDecoration(
            color: Color(0xffefefef),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
        ),
      ],
    );
  }
}
