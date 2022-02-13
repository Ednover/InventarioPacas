import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Buttons();
  }
}

class _Buttons extends State<Buttons> {
  bool _pressed = false;
  void onPressedFav() {
    setState(() {
      _pressed = !this._pressed;
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      content: this._pressed
          ? Text("Agregaste a tus Favoritos")
          : Text("Quitaste de tus Favoritos"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var inf = double.infinity;

    var vendidas = Expanded(
      flex: 5,
      child: Card(
        color: Colors.blue,
        child: InkWell(
          splashColor: Colors.white.withAlpha(30),
          onTap: () {},
          child: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
                Text(
                  "15",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "vendidas",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    var disponibles = Expanded(
      flex: 5,
      child: Card(
        color: Colors.blue,
        child: InkWell(
          splashColor: Colors.white.withAlpha(30),
          onTap: () {},
          child: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
                Text(
                  "35",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "disponibles",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final ventas = Card(
      color: Colors.blue,
      child: InkWell(
        splashColor: Colors.white.withAlpha(30),
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
              Text(
                "15000",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Ventas",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );

    final gastos = Card(
      color: Colors.blue,
      child: InkWell(
        splashColor: Colors.white.withAlpha(30),
        onTap: () {},
        child: Container(
          width: inf,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
              Text(
                "50000",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "gastos",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );

    var cards = Container(
      child: Column(
        children: [],
      ),
    );

    return Container(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [vendidas, disponibles],
          ),
          ventas,
          gastos,
        ],
      ),
    );

    // Center(
    //     child: ElevatedButton(
    //         onPressed: onPressedFav,
    //         //style: ButtonStyle(backgroundColor: ),
    //         child: Card(
    //           color: Colors.blue,
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               Icon(
    //                 Icons.favorite,
    //                 color: Colors.green,
    //               ),
    //               Text("15000")
    //             ],
    //           ),
    //           margin: EdgeInsets.all(30),
    //         )));

    // FloatingActionButton(
    //   backgroundColor: Colors.lightGreenAccent[700],
    //   mini: true,
    //   tooltip: "Fav",
    //   onPressed: onPressedFav,
    //   child: Icon(this._pressed ? Icons.favorite : Icons.favorite_border),
  }
}
