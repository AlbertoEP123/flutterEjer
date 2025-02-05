import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantalla_carga.dart';
import 'package:proyecto_flutter_vuelos/persistencia/bd_configuracion.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  BdConfiguracion.initDatabase();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReservaTusVuelosHD',
     
      home: PantallaCarga(),
    );
  }
}


 


