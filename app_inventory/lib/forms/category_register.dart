import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../classes/paca.dart';
import '../classes/provider.dart';

class CategoryRegister extends StatefulWidget {
  @override
  State<CategoryRegister> createState() => _CategoryRegisterState();
}

class _CategoryRegisterState extends State<CategoryRegister> {
  final formKey = GlobalKey<FormState>();
  Paca paca = new Paca();
  Provider provider = new Provider();
  List providers;
  List labels;
  String valueProvider = null;
  String valueLabel = null;
  bool enableLabelTextForm = false;
  bool enableProviderTextFrom = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providers = [];
    labels = [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: alertSaveOn,
        child: const Icon(
          Icons.check,
        ),
      ),
      appBar: AppBar(
        title: Text("Registro de Categoria"),
      ),
      body: FutureBuilder(
        future: getLabelsProviders(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return registerForm();
        },
      ),
    );
  }

  Future<bool> getLabelsProviders() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Providers');
    QuerySnapshot querySnapshot = await collectionReference.get();
    if (querySnapshot.docs.length > 0) {
      for (var doc in querySnapshot.docs) {
        providers.add(doc.get('name'));
      }
      providers.add('Agregar nuevo proveedor');
    } else {
      providers.add('Agregar nuevo proveedor');
    }
    collectionReference = FirebaseFirestore.instance.collection('Labels');
    querySnapshot = await collectionReference.get();
    if (querySnapshot.docs.length > 0) {
      for (var doc in querySnapshot.docs) {
        labels.add(doc.get('name'));
      }
      labels.add('Agregar nueva etiqueta');
      return true;
    } else {
      labels.add('Agregar nueva etiqueta');
    }
    return true;
  }

  Widget registerForm() {
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
        children: <Widget>[
          TextFormField(
            style: TextStyle(height: 2),
            decoration: InputDecoration(
              labelText: "Nombre de paca",
              labelStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(),
            ),
            validator: (value) => value != null && value.length < 5
                ? 'Nombre no válido, al menos 5 letras'
                : null,
            onSaved: (value) => paca.setName(value),
          ),
          const SizedBox(height: 20),
          Container(
            child: DropdownButton(
              hint: Text('Selecciona una etiqueta'),
              value: valueLabel,
              items: labels.map((label) {
                return DropdownMenuItem(value: label, child: Text(label));
              }).toList(),
              onChanged: (onChanged) {
                setState(() {
                  valueLabel = onChanged;
                  (valueLabel == labels.last)
                      ? enableLabelTextForm = true
                      : enableLabelTextForm = false;
                  paca.setLabel(valueLabel);
                });
              },
            ),
          ),
          Visibility(
            visible: enableLabelTextForm,
            child: TextFormField(
              style: TextStyle(height: 2),
              decoration: InputDecoration(
                labelText: "Etiqueta",
                labelStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == "" ? 'Etiqueta no válido' : null,
              onSaved: (value) => paca.setLabel(value),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            child: DropdownButton(
              hint: Text('Selecciona un proveedor'),
              value: valueProvider,
              items: providers.map((provider) {
                return DropdownMenuItem(value: provider, child: Text(provider));
              }).toList(),
              onChanged: (onChanged) {
                setState(() {
                  valueProvider = onChanged;
                  (valueProvider == providers.last)
                      ? enableProviderTextFrom = true
                      : enableProviderTextFrom = false;
                  paca.setProvider(valueProvider);
                });
              },
            ),
          ),
          Visibility(
            visible: enableProviderTextFrom,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(height: 2),
                  decoration: InputDecoration(
                    labelText: "Proveedor",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == "" ? 'Proveedor no válido' : null,
                  onSaved: (value) {
                    paca.setProvider(value);
                    provider.setName(value);
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(height: 2),
                  decoration: InputDecoration(
                    labelText: "Lugar",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == "" ? 'Lugar no válido' : null,
                  onSaved: (value) => provider.setLocale(value),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(height: 2),
                  decoration: InputDecoration(
                    labelText: "Telefono",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => value == "" || value.length != 10
                      ? 'Telefono no válido, deber tener 10 digitos'
                      : null,
                  onSaved: (value) => provider.setPhone(int.parse(value)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: TextStyle(height: 2),
            decoration: InputDecoration(
              labelText: "Precio",
              labelStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) =>
                value == "" ? 'Precio no válido, debe ser mayor a 0' : null,
            onSaved: (value) => paca.setPrice(double.parse(value)),
          ),
        ],
      ),
    );
  }

  void alertSaveOn() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Aviso'),
          content: const Text('¿Seguro que desea registrar esta categoría?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.pop(context, 'Cancel'),
            ),
            TextButton(
              child: const Text('Si'),
              onPressed: () {
                CollectionReference collectionReference;
                if (enableLabelTextForm) {
                  collectionReference =
                      FirebaseFirestore.instance.collection('Labels');
                  collectionReference.add({"name": paca.getLabel()});
                }
                if (enableProviderTextFrom) {
                  collectionReference =
                      FirebaseFirestore.instance.collection('Providers');
                  collectionReference.add({
                    "name": provider.getName(),
                    "locale": provider.getLocale(),
                    "phone": provider.getPhone()
                  });
                }

                collectionReference =
                    FirebaseFirestore.instance.collection('Inventory');
                collectionReference.add({
                  "name": paca.getName(),
                  "label": paca.getLabel(),
                  "provider": paca.getProvider(),
                  "price": paca.getPrice(),
                  "amount": 0,
                  "updateDate": DateTime.now()
                });
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }
}
