import 'package:flutter/material.dart';

import '../classes/paca.dart';

class PacaInfo extends StatefulWidget {
  Paca paca;

  PacaInfo({@required this.paca}) : super();

  @override
  State<StatefulWidget> createState() {
    return _PacaInfo();
  }
}

class _PacaInfo extends State<PacaInfo> {
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

    void alertEditOn (){
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
      initialValue: widget.paca.getName(),
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Paca",
        labelStyle: TextStyle(fontSize: 20, color: colorLabel),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorOff),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorField),
        ),
      ),
      readOnly: isOnlyRead,
    );

    var labelPrice = TextFormField(
      initialValue: widget.paca.getPrice().toString(),
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Precio",
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
    );

    var labelAmount = TextFormField(
      initialValue: widget.paca.getAmount().toString(),
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
    ); 

    var labelProvider = TextFormField(
      initialValue: widget.paca.getProvider(),
      style: TextStyle(height: 2),
      decoration: InputDecoration(
        labelText: "Provedor",
        labelStyle: TextStyle(fontSize: 20, color: colorLabel),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorOff),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorField),
        ),
      ),
      readOnly: isOnlyRead,
    );

    var containerInfo = Container(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Column(
        children: <Widget>[
          labelName,
          labelPrice,
          labelAmount,
          labelProvider,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            if (isModeEdit) {
              alertEditOn();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text("Pacas", textAlign: TextAlign.center),
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
      body: containerInfo,
    );
  }
}