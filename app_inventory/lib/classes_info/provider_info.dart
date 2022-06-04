import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classes/provider.dart';

final colorOff = Colors.grey;
final colorOn = Colors.blue;

class ProviderInfo extends StatefulWidget {
  final Provider provider;

  ProviderInfo({@required this.provider}) : super();

  @override
  _ProviderInfo createState() => _ProviderInfo();
}

class _ProviderInfo extends State<ProviderInfo> {
  var colorField = Colors.grey;
  var colorLabel = Colors.black54;

  var isOnlyRead = true;
  var isModeEdit = false;

  var nameController;
  var localeController;
  var phoneController;

  void changeMode(bool isModeEdit) {
    setState(() {
      this.isModeEdit = !isModeEdit;
      if (this.isModeEdit) {
        colorField = colorOn;
        colorLabel = null;
        isOnlyRead = false;
      } else {
        colorField = colorOff;
        colorLabel = Colors.black54;
        isOnlyRead = true;
      }
    });
  }

  CollectionReference providers =
      FirebaseFirestore.instance.collection('Providers');

  Future<void> updateProvider() {
    print(widget.provider.getId());
    print(localeController.text);
    return providers
        .doc(widget.provider.getId())
        .update({
          'name': nameController.text,
          'locale': localeController.text,
          'phone': int.parse(phoneController.text),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.provider.getName());
    localeController = TextEditingController(text: widget.provider.getLocale());
    phoneController =
        TextEditingController(text: widget.provider.getPhone().toString());
  }

  @override
  Widget build(BuildContext context) {
    var iconCheck = FloatingActionButton(
      child: const Icon(Icons.check),
      backgroundColor: Colors.blue,
      onPressed: () {
        updateProvider();
        changeMode(isModeEdit);
      },
    );

    var iconEdit = FloatingActionButton(
      child: const Icon(Icons.edit),
      backgroundColor: Colors.blue,
      onPressed: () {
        changeMode(isModeEdit);
      },
    );

    var buttonBack = IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: () {
        if (isModeEdit) {
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
        } else {
          Navigator.pop(context);
        }
      },
    );

    var labelName = TextFormField(
      controller: nameController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Nombre",
        labelStyle: TextStyle(fontSize: 20, color: colorLabel),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorOff),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorField),
        ),
      ),
      validator: (value) {
        widget.provider.setName(value);
        return null;
      },
      readOnly: isOnlyRead,
    );

    var labelLocale = TextFormField(
      controller: localeController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Ciudad",
        labelStyle: TextStyle(fontSize: 20, color: colorLabel),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorOff),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorField),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        widget.provider.setLocale(value);
        return null;
      },
      readOnly: isOnlyRead,
    );

    var labelPhone = TextFormField(
      controller: phoneController,
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Teléfono",
        labelStyle: TextStyle(fontSize: 20, color: colorLabel),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorOff),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorField),
        ),
      ),
      validator: (value) {
        widget.provider.setPhone(int.parse(value));
        return null;
      },
      readOnly: isOnlyRead,
      keyboardType: TextInputType.number,
    );

    return Scaffold(
      appBar: AppBar(
        leading: buttonBack,
        centerTitle: true,
        title: const Text("Cliente"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            labelName,
            labelLocale,
            labelPhone,
          ],
        ),
      ),
      floatingActionButton: (isModeEdit) ? iconCheck : iconEdit,
    );
  }
}
