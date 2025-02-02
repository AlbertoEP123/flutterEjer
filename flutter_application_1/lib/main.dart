import 'package:flutter/material.dart';

import 'package:flutter_application_1/screens/ejercicios.dart';

import 'routes/app_routes.dart';

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
      initialRoute: AppRoutes.home,  // Ruta principal desde approutes
      routes: AppRoutes.routes,
     
      //ESTO ERA LAS RUTAS NOMBRADAS, QUE YA NO LA USO POR USAR LAS RUTAS EXTERNAS DE ARRIBA
      // LO DEJO COMENTADO PARA QUE SE VEA QUE ESTABA HECHO DE LA RELACION 3
      /* initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/ejercicio_2': (context) => const Ejercicio2(),
        '/ejercicio_3': (context) => const Ejercicio3(),
        '/ejercicio_4': (context) => const Ejercicio4(),
        '/ejercicio_5': (context) => const Ejercicio5(),
        '/ejercicio_6': (context) => const Ejercicio6(),
        '/ejercicio_7': (context) => const Ejercicio7(),
        '/instagram': (context) =>  Instagrampartealta(),
        '/ejercicio_9': (context) => const JuegoAleatorioScreen(),
      }, */
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