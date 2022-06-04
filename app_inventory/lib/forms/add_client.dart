import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddClient extends StatefulWidget {
  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final localeController = TextEditingController();
  final phoneController = TextEditingController();

  CollectionReference clients =
      FirebaseFirestore.instance.collection('Clients');

  Future<bool> addClient() async {
    // Call the user's CollectionReference to add a new user
    bool isAdd;
    await clients.add({
      'name': nameController.text,
      'last_name': lastNameController.text,
      'locale': localeController.text,
      'phone': int.parse(phoneController.text),
      'balance': 0,
      'debts': [],
      'payments': [],
    }).then((value) {
      print("Add client");
      isAdd = true;
    }).catchError((error) {
      print("Failed to add user: $error");
      isAdd = false;
    });
    return isAdd;
  }

  void validAddClient() async {
    var snackBarResponse;
    bool validQuery = await addClient();
    if (validQuery) {
      snackBarResponse = SnackBar(
        content: const Text('Cliente agregado'),
      );
    } else {
      snackBarResponse = SnackBar(
        content: const Text('Ocurrio un error'),
      );
    }
    //ScaffoldMessenger.of(context).showSnackBar(snackBarResponse);
  }

  @override
  Widget build(BuildContext context) {
    void alertExitPage() {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alerta'),
          content: const Text('¿Seguro que desea salir sin guardar?'),
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
    }

    var labelName = TextFormField(
      controller: nameController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Nombre",
        labelStyle: TextStyle(fontSize: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else {
          nameController.text = value;
        }
        return null;
      },
    );

    var labelLastName = TextFormField(
      controller: lastNameController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Apellido",
        labelStyle: TextStyle(fontSize: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );

    var labelLocale = TextFormField(
      controller: localeController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Ciudad",
        labelStyle: TextStyle(fontSize: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );

    var labelPhone = TextFormField(
      controller: phoneController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Teléfono",
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

    var containerInfo = Container(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Column(
        children: <Widget>[
          labelName,
          labelLastName,
          labelLocale,
          labelPhone,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            alertExitPage();
          },
        ),
        title: const Text("Agregar cliente"),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              validAddClient();
              Navigator.pop(context);
            },
            child: Text("Guardar"),
            style: TextButton.styleFrom(primary: Colors.white),
          )
        ],
      ),
      body: containerInfo,
    );
  }
}
