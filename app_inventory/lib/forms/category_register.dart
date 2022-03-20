import 'package:flutter/material.dart';

class CategoryRegister extends StatefulWidget {
  @override
  State<CategoryRegister> createState() => _CategoryRegisterState();
}

class _CategoryRegisterState extends State<CategoryRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Categoria"),
      ),
    );
  }
}
