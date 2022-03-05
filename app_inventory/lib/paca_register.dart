import 'package:app_inventory/paca_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'paca.dart';

List<Paca> categoryPacas = [];
List<Paca> listPaca = [];

class PacaRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PacaRegister();
  }
}

class _PacaRegister extends State<PacaRegister> {
  Paca _dropdownValue;
  TextEditingController _priceController = TextEditingController();
  bool _isEnabledFieldPrice;
  int _amountPacas;
  BoxDecoration _boxDecorationAlert;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryPacas();
  }

  void getCategoryPacas() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Inventory');
    QuerySnapshot querySnapshot = await collectionReference.get();
    if (querySnapshot.docs.length > 0) {
      for (var doc in querySnapshot.docs) {
        categoryPacas.add(Paca(
            name: doc.get('name'),
            price: doc.get('price').toDouble(),
            provider: doc.get('provider')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
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
                    if (identical(listPaca[i].name, itemPaca.name)) {
                      indexMatch = i;
                    }
                  }
                  if (indexMatch == null) {
                    listPaca.add(itemPaca);
                  } else {
                    listPaca[indexMatch].amount =
                        listPaca[indexMatch].amount + itemPaca.amount;
                    print(listPaca[indexMatch].amount);
                  }
                }
              });
            },
          ),
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
                      name: listPaca[index].name,
                      price: listPaca[index].price,
                    ),
                  )),
        ),
      ],
    );
  }

  Future<Paca> showDialogAddCart() {
    _amountPacas = 0;
    _dropdownValue = null;
    _isEnabledFieldPrice = false;
    _priceController = TextEditingController();
    Paca itemPaca = Paca();
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
                          value: tipoPaca, child: Text(tipoPaca.name));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _dropdownValue = newValue;
                        _priceController.text = _dropdownValue.price.toString();
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                                  (_amountPacas > 1)
                                      ? _amountPacas--
                                      : print('');
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
                onPressed: () {},
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
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
                      name: _dropdownValue.name,
                      price: _dropdownValue.price,
                      amount: _amountPacas);
                  Navigator.of(context).pop(itemPaca);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
