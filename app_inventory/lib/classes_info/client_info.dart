import 'package:flutter/material.dart';

class ClientInfo extends StatefulWidget {
  final String name;
  final double amount;

  ClientInfo({@required this.name, this.amount}) : super();

  @override
  State<StatefulWidget> createState() {
    return _ClientInfo();
  }
}

class _ClientInfo extends State<ClientInfo> {
  var isOnlyRead = true;

  var isModeEdit = false;

  var barIcon;

  final colorOff = Colors.grey;
  final colorOn = Colors.blue;

  var colorField = Colors.grey;
  var colorLabel = Colors.black54;

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

  @override
  Widget build(BuildContext context) {
    var iconEdit = IconButton(
      icon: const Icon(Icons.edit),
      color: Colors.white,
      onPressed: () {
        changeMode(isModeEdit);
      },
    );

    var iconCheck = IconButton(
      icon: const Icon(Icons.check),
      color: Colors.white,
      onPressed: () {
        changeMode(isModeEdit);
      },
    );

    barIcon = iconEdit;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
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
        ),
        centerTitle: true,
        title: const Text("Cliente"),
        actions: <Widget>[
          Visibility(
            child: iconEdit,
            visible: !isModeEdit,
          ),
          Visibility(
            child: iconCheck,
            visible: isModeEdit,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: widget.name,
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
              readOnly: isOnlyRead,
            ),
            TextFormField(
              initialValue: widget.amount.toString(),
              style: TextStyle(height: 2),
              decoration: InputDecoration(
                labelText: "Cantidad",
                labelStyle: TextStyle(fontSize: 20, color: colorLabel),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorOff),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorField),
                ),
              ),
              readOnly: isOnlyRead,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
