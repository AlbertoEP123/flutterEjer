import 'package:flutter/material.dart';


class Enlace2 extends StatelessWidget {
  const Enlace2({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segunda pantalla"),
      ),
      body: const Center(
        child: Text("Parte central"),
      ),
    );
  }
}
