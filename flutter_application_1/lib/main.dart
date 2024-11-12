import 'package:flutter/material.dart';

import 'package:flutter_application_1/ejercicios/ejercicios.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drawer',
      initialRoute: '/', 
      routes: {
        '/': (context) => const HomeScreen(), 
        '/ejercicio2': (context) => const Ejercicio2(),
        '/ejercicio3': (context) => const Ejercicio3(),
        '/ejercicio4': (context) => const Ejercicio4(),
        '/ejercicio5': (context) => const Ejercicio5(),
        '/ejercicio6': (context) => const Ejercicio6(),
        '/ejercicio7': (context) => const Ejercicio7(),
        '/instagram': (context) => const Instagrampartealta(),
        '/ejercicio9': (context) => const JuegoAleatorioScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drawer"),
      ),
      drawer: const MenuLateral(),
      body: Center(
        child: Text(
          "Alberto Enrique Pulido \nhttps://github.com/AlbertoEP123/flutterEjer",
          style: TextStyle(
            color: const Color.fromARGB(255, 114, 7, 255),
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}