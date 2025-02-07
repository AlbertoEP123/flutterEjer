import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantalla_carga.dart';
import 'package:proyecto_flutter_vuelos/persistencia/bd_configuracion.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Initializo sqflitefniinit, sirve para que funcione sqlite en windows
  sqfliteFfiInit();
  // creo factoria de database
  databaseFactory = databaseFactoryFfi;
  //inicializo mi base de datos
  BdConfiguracion.initDatabase();
  
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GuardaTusVuelosHD',
      // inicializo pantalla de carga
      home: PantallaCarga(),
    );
  }
}


 


