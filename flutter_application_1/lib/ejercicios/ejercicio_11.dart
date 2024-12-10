import 'package:flutter/material.dart';





class Ejercicio11 extends StatelessWidget {
  const Ejercicio11({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ejemplo de formularios',
      home: MyHomePage(title: 'Formularios'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  Widget textoEntrada() {
    return SingleChildScrollView(
        child: TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          hintText: 'Entrada de texto',
          counterText: 'Texto de abajo',
          labelText: 'Datos',
          suffixIcon: const Icon(Icons.rtt),
          icon: const Icon(Icons.group),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
      onChanged: (text) {
        AlertDialog(semanticLabel: "Texto en el formulario de entrada: $text");
      },
      onSubmitted: (String valor) {
        AlertDialog(semanticLabel: "El texto inintroducido es: $valor");
      },
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: textoEntrada()),
    );
  }
}
