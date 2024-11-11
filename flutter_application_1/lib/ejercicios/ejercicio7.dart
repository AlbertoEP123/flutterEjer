import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/drawer.dart';

class Ejercicio7 extends StatelessWidget {
  const Ejercicio7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicio 7. Filas y columnas anidadas"),
      ),
      drawer: MenuLateral(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Primera fila
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("assets/tlf.webp", fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 50), // Espacio entre imágenes
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("assets/mens.webp", fit: BoxFit.cover),
                  ),
                ],
              ),
              const SizedBox(width: 50), // Espacio entre columnas
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("assets/ig.webp", fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 50), 
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("assets/was.webp", fit: BoxFit.cover),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 50), 
        
        ],
      ),
    );
  }
}
