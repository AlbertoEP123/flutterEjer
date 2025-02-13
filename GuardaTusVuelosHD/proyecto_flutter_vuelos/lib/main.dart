import 'package:flutter/material.dart';
import 'dart:io';
import 'package:proyecto_flutter_vuelos/pantallas/pantalla_carga.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  
  if(Platform.isWindows){
    // Initializo sqflitefniinit, sirve para que funcione sqlite en windows
   sqfliteFfiInit();
    // creo factoria de database
  databaseFactory = databaseFactoryFfi;
  }
  
  
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


 


