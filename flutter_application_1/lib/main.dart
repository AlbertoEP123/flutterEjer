import 'package:flutter/material.dart';

import 'package:flutter_application_1/ejercicios/ejercicios.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Defino el tema
      theme: ThemeData(
        primarySwatch: Colors.blue,

        // Estilo de texto
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              fontSize: 18.0, color: Colors.black), // Estilo para texto normal
          bodyMedium: TextStyle(
              fontSize: 16.0,
              color: Colors.black54), // Estilo para texto secundario
          titleLarge: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black), // Títulos
        ),

        // Botones
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue, // Color de los botones
          textTheme: ButtonTextTheme.primary, // Tema del texto en los botones
        ),
      ),
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
        '/instagram': (context) =>  Instagrampartealta(),
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
        title: Text("Drawer", style: Theme.of(context).textTheme.titleLarge),
      ),
      drawer: const MenuLateral(),
      body: Center(
        child: Text(
          "Alberto Enrique Pulido \nhttps://github.com/AlbertoEP123/flutterEjer",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
