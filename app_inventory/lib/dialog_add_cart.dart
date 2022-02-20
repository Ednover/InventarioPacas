import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'paca.dart';

List<Paca> categoryPacas = [
  Paca(nombre: 'Mujer Mixta', precio: 8000),
  Paca(nombre: 'Deportiva Mixta', precio: 10000)
];

List<Paca> _listPaca = [];

class DialogRegistro extends StatefulWidget {
  DialogRegistro({Key key}) : super(key: key);

  @override
  _DialogRegistroState createState() => _DialogRegistroState();
}

class _DialogRegistroState extends State<DialogRegistro> {
  Paca _dropdownValue;
  TextEditingController _priceController = TextEditingController();
  bool _isEnabledFieldPrice;
  int _amountPacas;
  BoxDecoration _boxDecorationAlert;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        _dropdownValue = null;
        _priceController.text = "";
        _isEnabledFieldPrice = false;
        _amountPacas = 1;
        _boxDecorationAlert = null;
        return showDialog(
            context: context,
            //El StatefulBuilder es para poder actualizar el state en el AlertDialog
            builder: (BuildContext context) => StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    title: const Text('Añadir Paca al listado'),
                    content: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
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
                                            value: tipoPaca,
                                            child: Text(tipoPaca.nombre));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _dropdownValue = newValue;
                                          _priceController.text =
                                              _dropdownValue.precio.toString();
                                          _isEnabledFieldPrice = true;
                                          _boxDecorationAlert = null;
                                        });
                                      })),
                              TextButton(
                                child: Text('Añadir\nCategoria',
                                    textAlign: TextAlign.center),
                                onPressed: () {},
                              ),
                            ]),
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
                              decoration: BoxDecoration(
                                  color: Colors.red[600],
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 6.0,
                                      color: Colors.blue[400],
                                      offset: Offset(0.0, 1.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50.0),
                                  )),
                              margin: EdgeInsets.only(top: 20.0),
                              padding: EdgeInsets.all(2.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        (_amountPacas > 1)
                                            ? _amountPacas--
                                            : print('');
                                      });
                                      //_removeProduct(index);
                                      //valorTotal(_cart);
                                      // print(_cart);
                                    },
                                    color: Colors.yellow,
                                  ),
                                  Text('$_amountPacas',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0,
                                          color: Colors.white)),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        _amountPacas++;
                                      });
                                      //_addProduct(index);
                                      //valorTotal(_cart);
                                    },
                                    color: Colors.yellow, // print(_cart);
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          (_dropdownValue == null)
                              ? setState(() {
                                  _boxDecorationAlert = BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.red,
                                          width: 1,
                                          style: BorderStyle.solid));
                                })
                              : _addPaca(_dropdownValue.nombre,
                                  _dropdownValue.precio, _amountPacas);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ));
      },
    );
  }
}

_addPaca(String paca, int price, int amount) {
  _listPaca = [];
  if (paca != null) {
    for (var i = 0; i < amount; i++) {
      _listPaca.add(Paca(nombre: paca, precio: price));
    }
  }
}

ListTile createlistPacas() {
  for (var itemPaca in _listPaca) {
    return ListTile(
      title: Text(itemPaca.nombre),
      subtitle: Text(itemPaca.precio.toString()),
    );
  }
}

List<Widget> _dialogActions() {
  return [];
}
