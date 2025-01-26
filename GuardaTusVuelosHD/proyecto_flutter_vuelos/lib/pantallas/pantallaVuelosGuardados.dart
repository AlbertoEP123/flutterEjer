import 'package:flutter/material.dart';

class Pantallavuelosguardados extends StatelessWidget {
  const Pantallavuelosguardados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vuelos guardados"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Text('Pantalla vuelos Guardaos'),
         
        ],
      ),
    );
  }
}