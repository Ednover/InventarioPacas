import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classes/client.dart';

class ClientPayment extends StatefulWidget {
  final Client client;

  ClientPayment({@required this.client}) : super();

  @override
  State<ClientPayment> createState() => _ClientPayment();
}

class _ClientPayment extends State<ClientPayment> {
  var totalController = TextEditingController();
  var nameController;
  var balanceController;

  CollectionReference clients =
      FirebaseFirestore.instance.collection('Clients');

  //reutilizar en otra parte, ahora ya no sirve
  Future<void> queryClient() async {
    return clients
        .doc(widget.client.getId())
        .get()
        .then(
          (value) {
            widget.client.setName(value.get('name'));
            widget.client.setLastName(value.get('last_name'));
            widget.client.setLocale(value.get('locale'));
            widget.client.setPhone(value.get('phone'));
            widget.client
                .setBalance(double.parse(value.get('balance').toString()));
          },
        )
        .then((value) => print("Success query"))
        .catchError((error) => print("Failed to query: $error"));
  }

  Future<void> updateBalanceClient() async {
    List<Map<String, Object>> payments = [];
    payments.add(
      {
        'total': int.parse(totalController.text),
        'date': DateTime.now(),
      },
    );
    return clients
        .doc(widget.client.getId())
        .update({
          'balance': FieldValue.increment(-int.parse(totalController.text)),
          'payments': FieldValue.arrayUnion(payments),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void refreshClient() async {
    await queryClient();
    setState(() {
      nameController = TextEditingController(
        text: widget.client.getName() + ' ' + widget.client.getLastName(),
      );
      balanceController = TextEditingController(
        text: widget.client.getBalance().toString(),
      );
    });
  }

  void initState() {
    super.initState();
    refreshClient();
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
        await updateBalanceClient();
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
        title: const Text("Pago del cliente"),
        centerTitle: true,
      ),
      body: containerBody,
      floatingActionButton: buttonCheck,
    );
  }
}
