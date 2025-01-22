import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/pantallas/drawerInicio.dart';  

class Pantallabusqueda extends StatelessWidget {
  const Pantallabusqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Busqueda de vuelos"),
      ),
      drawer: const Drawerinicio(),  
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Text('Pantalla de Busqueda de Vuelos'),
         
        ],
      ),
    );
  }
}
