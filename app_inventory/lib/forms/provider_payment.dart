import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classes/provider.dart';

class ProviderPayment extends StatefulWidget {
  final Provider provider;

  ProviderPayment({@required this.provider}) : super();

  @override
  _ProviderPayment createState() => _ProviderPayment();
}

class _ProviderPayment extends State<ProviderPayment> {
  var totalController = TextEditingController();
  var nameController;
  var balanceController;

  CollectionReference providers =
      FirebaseFirestore.instance.collection('Providers');

  //reutilizar en otra parte, ahora ya no sirve
  Future<void> queryProvider() async {
    return providers
        .doc(widget.provider.getId())
        .get()
        .then(
          (value) {
            widget.provider.setName(value.get('name'));
            widget.provider.setLocale(value.get('locale'));
            widget.provider.setPhone(value.get('phone'));
            widget.provider
                .setBalance(double.parse(value.get('balance').toString()));
          },
        )
        .then((value) => print("Success query"))
        .catchError((error) => print("Failed to query: $error"));
  }

  Future<void> updateBalanceProvider() async {
    List<Map<String, Object>> payments = [];
    payments.add(
      {
        'total': int.parse(totalController.text),
        'date': DateTime.now(),
      },
    );
    return providers
        .doc(widget.provider.getId())
        .update({
          'balance': FieldValue.increment(-int.parse(totalController.text)),
          'payments': FieldValue.arrayUnion(payments),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void refreshProvider() async {
    await queryProvider();
    setState(() {
      nameController = TextEditingController(
        text: widget.provider.getName(),
      );
      balanceController = TextEditingController(
        text: widget.provider.getBalance().toString(),
      );
    });
  }

  void initState() {
    super.initState();
    refreshProvider();
  }

  @override
  Widget build(BuildContext context) {
    var buttonBack = IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Alerta'),
            content: const Text('¿Seguro que desea salir sin realizar pago?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );

    var buttonCheck = FloatingActionButton(
      child: const Icon(Icons.check),
      backgroundColor: Colors.blue,
      onPressed: () async {
        await updateBalanceProvider();
        Navigator.pop(context);
      },
    );

    var labelName = TextFormField(
      controller: nameController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Nombre",
        labelStyle: TextStyle(fontSize: 20),
      ),
      enabled: false,
    );

    var labelBalance = TextFormField(
      controller: balanceController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Balance",
        labelStyle: TextStyle(fontSize: 20),
      ),
      enabled: false,
    );

    var labelTotal = TextFormField(
      controller: totalController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Monto",
        labelStyle: TextStyle(fontSize: 20),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );

    var containerBody = Container(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Column(
        children: <Widget>[
          labelName,
          labelBalance,
          labelTotal,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: buttonBack,
        title: const Text("Pago proveedor"),
        centerTitle: true,
      ),
      body: containerBody,
      floatingActionButton: buttonCheck,
    );
  }
}
