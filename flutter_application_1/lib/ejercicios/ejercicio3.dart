import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/drawer.dart';

class Ejercicio3 extends StatelessWidget {
  const Ejercicio3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicio 3. 3 Fotos en miniatura en columna"),
      ),
      drawer: MenuLateral(),

      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset("assets/image.png", fit: BoxFit.cover),
            ),
            const SizedBox(height: 10), // Espacio entre imágenes
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset("assets/image.png", fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset("assets/image.png", fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
