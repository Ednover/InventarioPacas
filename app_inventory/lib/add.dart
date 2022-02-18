import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Paca> tipoPacas = [
  Paca(nombre: 'Mujer Mixta', precio: 8000),
  Paca(nombre: 'Deportiva Mixta', precio: 10000)
];

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        ListView(
          padding: EdgeInsets.only(top: 10),
          children: <Widget>[
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.lightBlue,
                shape: CircleBorder(),
              ),
              child: DialogRegistro(),
            ),
          ],
        ),
      ],
    );
  }
}

class DialogRegistro extends StatefulWidget {
  DialogRegistro({Key key}) : super(key: key);

  @override
  _DialogRegistroState createState() => _DialogRegistroState();
}

class _DialogRegistroState extends State<DialogRegistro> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          dropdownValue = null;
          return showDialog(
              context: context,
              //El StatefulBuilder es para poder actualizar el state en el AlertDialog
              builder: (BuildContext context) => StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                      title: const Text('Añadir Paca al listado'),
                      content: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton(
                                    hint: Text('Seleccione una opción'),
                                    value: dropdownValue,
                                    items: tipoPacas.map((tipoPaca) {
                                      return DropdownMenuItem(
                                          value: tipoPaca.nombre,
                                          child: Text(tipoPaca.nombre));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    }),
                                TextButton(
                                    onPressed: () {},
                                    child: Text('Añadir categoria')),
                              ]),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ));
        },
        icon: Icon(Icons.add));
  }
}

class Paca {
  String nombre;
  int precio;

  Paca({this.nombre, this.precio});
}
