import 'package:app_inventory/forms/category_register.dart';
import 'package:app_inventory/home/cards/paca_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../classes/paca.dart';

List<Paca> categoryPacas = [];
List<Paca> listPaca = [];

class PacaRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PacaRegister();
  }
}

class _PacaRegister extends State<PacaRegister> {
  Paca _dropdownValue;
  TextEditingController _priceController = TextEditingController();
  bool _isEnabledFieldPrice;
  int _amountPacas;
  BoxDecoration _boxDecorationAlert;
  bool isUploadEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getCategoryPacas() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Inventory');
    QuerySnapshot querySnapshot = await collectionReference.get();
    if (querySnapshot.docs.length > 0) {
      for (var doc in querySnapshot.docs) {
        categoryPacas.add(Paca(
            id: doc.id,
            name: doc.get('name'),
            price: doc.get('price').toDouble(),
            provider: doc.get('provider')));
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    (listPaca.isNotEmpty) ? isUploadEnabled = true : isUploadEnabled = false;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: const ShapeDecoration(
                color: Colors.lightBlue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  final itemPaca = await showDialogAddCart();
                  if (itemPaca == null) return;
                  setState(() {
                    if (listPaca.isEmpty) {
                      listPaca.add(itemPaca);
                    } else {
                      int indexMatch = null;
                      for (int i = 0; i < listPaca.length; i++) {
                        if (listPaca[i].getName() == itemPaca.getName()) {
                          indexMatch = i;
                        }
                      }
                      if (indexMatch == null) {
                        listPaca.add(itemPaca);
                      } else {
                        listPaca[indexMatch].setAmount(
                            listPaca[indexMatch].getAmount() +
                                itemPaca.getAmount());
                      }
                    }
                  });
                },
              ),
            ),
            SizedBox(width: 15),
            Visibility(
                visible: isUploadEnabled,
                child: Ink(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: const ShapeDecoration(
                    color: Colors.lightBlue,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.cloud_upload),
                    onPressed: uploadRegister,
                  ),
                ))
          ],
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => Container(
                    height: 10,
                  ),
              itemCount: listPaca.length,
              itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: PacaCard(
                        paca: new Paca(
                      id: listPaca[index].getId(),
                      name: listPaca[index].getName(),
                      amount: listPaca[index].getAmount(),
                      price: listPaca[index].getPrice(),
                      label: listPaca[index].getLabel(),
                      provider: listPaca[index].getProvider(),
                    )),
                  )),
        ),
      ],
    );
  }

  void uploadRegister() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Añadir al Inventario'),
        content: const Text(
            'Se añadirán las cantidades de las pacas al inventario.\n¿Desea continuar?'),
        actions: [
          TextButton(
            child: const Text('No'),
            onPressed: () => Navigator.pop(context, 'Cancel'),
          ),
          TextButton(
            child: const Text('Si'),
            onPressed: () async {
              for (var item in listPaca) {
                await updateInventory(item);
                //await addInputs(item);
                //await updateDebtsProvider(item);
              }
              setState(() {
                listPaca = [];
                Navigator.pop(context, 'OK');
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> updateInventory(Paca item) async {
    CollectionReference inventory =
        FirebaseFirestore.instance.collection('Inventory');
    return inventory.doc(item.getId()).update(
      {
        "amount": FieldValue.increment(item.getAmount()),
        "updateDate": DateTime.now(),
      },
    );
  }

  Future<void> addInputs(Paca item) async {
    CollectionReference inputs =
        FirebaseFirestore.instance.collection('Inputs');
    return inputs.add(
      {
        'id_paca': item.getId(),
        'amount': item.getAmount(),
        'subtotal': item.getPrice(),
        'total': item.getPrice() * item.getAmount(),
        //'id_provider': widget.provider.getId(),
        'date': DateTime.now(),
      },
    );
  }

  Future<void> updateDebtsProvider(Paca item) async {
    List<Map<String, Object>> debts = [];
    debts.add(
      {
        'total': item.getPrice() * item.getAmount(),
        'date': DateTime.now(),
      },
    );
    CollectionReference providers =
        FirebaseFirestore.instance.collection('Providers');
    /* return clients.doc(widget.provider.getId()).update(
      {
        'balance': FieldValue.increment(
          item.getPrice() * item.getAmount(),
        ),
        'debts': FieldValue.arrayUnion(debts),
      },
    ); */
  }

  // ignore: missing_return
  Future<Paca> showDialogAddCart() async {
    _amountPacas = 0;
    _dropdownValue = null;
    _isEnabledFieldPrice = false;
    _priceController = TextEditingController();
    Paca itemPaca = Paca();
    bool showAlert = await getCategoryPacas();
    if (showAlert) {
      return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Añadir Paca al listado'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //DropDownMenu
                AnimatedContainer(
                  duration: Duration(seconds: 2),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: _boxDecorationAlert,
                  child: DropdownButton(
                      hint: Text('Seleccione una opción'),
                      value: _dropdownValue,
                      items: categoryPacas.map((tipoPaca) {
                        return DropdownMenuItem(
                            value: tipoPaca, child: Text(tipoPaca.getName()));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _dropdownValue = newValue;
                          _priceController.text =
                              _dropdownValue.getPrice().toStringAsFixed(0);
                          _isEnabledFieldPrice = true;
                          _boxDecorationAlert = null;
                          _amountPacas = 1;
                        });
                      }),
                ),
                //TextForm del precio y botones de cantidad
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //TextFormField del precio
                    Container(
                      width: 100,
                      child: TextFormField(
                        enabled: _isEnabledFieldPrice,
                        controller: _priceController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Precio',
                            labelText: 'Precio'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    //Boton de cantidad de Pacas
                    Container(
                      width: 120,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Color(0xffefefef),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                      padding: EdgeInsets.all(2.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Color(0xffefefef),
                              child: IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (_amountPacas > 1) _amountPacas--;
                                  });
                                },
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '$_amountPacas',
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Color(0xffefefef),
                              child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _amountPacas++;
                                  });
                                },
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //TextoButton para añadir nueva categoría
                TextButton(
                  child: Text('Añadir\nCategoria', textAlign: TextAlign.center),
                  onPressed: () {
                    categoryPacas = [];
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryRegister()));
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  categoryPacas = [];
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  if (_dropdownValue == null) {
                    setState(() {
                      _boxDecorationAlert = BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid));
                    });
                  } else {
                    itemPaca = Paca(
                        id: _dropdownValue.getId(),
                        name: _dropdownValue.getName(),
                        price: double.parse(_priceController.text),
                        amount: _amountPacas);
                    categoryPacas = [];
                    Navigator.of(context).pop(itemPaca);
                    return itemPaca;
                  }
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
