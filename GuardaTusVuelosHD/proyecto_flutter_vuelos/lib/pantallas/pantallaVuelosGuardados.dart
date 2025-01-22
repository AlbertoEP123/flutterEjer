import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/pantallas/drawerInicio.dart';

class Pantallavuelosguardados extends StatelessWidget {
  const Pantallavuelosguardados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vuelos guardados"),
      ),
      drawer: const Drawerinicio(),  
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