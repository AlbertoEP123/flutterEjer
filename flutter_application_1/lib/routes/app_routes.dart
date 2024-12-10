import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/ejercicios.dart';  


import 'package:flutter_application_1/main.dart'; 

class AppRoutes {
  // Nombre de las rutas
  static const String home = '/';
  static const String ejercicio2 = '/ejercicio_2';
  static const String ejercicio3 = '/ejercicio_3';
  static const String ejercicio4 = '/ejercicio_4';
  static const String ejercicio5 = '/ejercicio_5';
  static const String ejercicio6 = '/ejercicio_6';
  static const String ejercicio7 = '/ejercicio_7';
  static const String instagram = '/instagram';
  static const String ejercicio9 = '/ejercicio_9';
  static const String ejercicio10 = '/ejercicio_10';
    static const String ejercicio11 = '/ejercicio_11';



  // Mapa de rutas
  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(), 
    ejercicio2: (context) => const Ejercicio2(),
    ejercicio3: (context) => const Ejercicio3(),
    ejercicio4: (context) => const Ejercicio4(),
    ejercicio5: (context) => const Ejercicio5(),
    ejercicio6: (context) => const Ejercicio6(),
    ejercicio7: (context) => const Ejercicio7(),
    instagram: (context) => const Instagrampartealta(),
    ejercicio9: (context) => const JuegoAleatorioScreen(),
    ejercicio10: (context) => const Ejercicio10(),
    ejercicio11: (context) => const Ejercicio11(),


  };
}
