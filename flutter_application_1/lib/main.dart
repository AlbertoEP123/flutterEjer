import 'package:flutter/material.dart';


import '/MenuLateral.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ejemplo de drawer',
        
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Ejemplo de Drawear"),
          ),
          
          drawer: const MenuLateral(),
          body: const Center(
            child: Text("Parte principal"),
          ),
        ));
  }
}



  

