import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/drawer.dart';

class Ejercicio6 extends StatelessWidget {
  const Ejercicio6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicio 6. Ejercicio teléfonos"),
      ),
      drawer: const MenuLateral(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Primera fila con una columna
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,  // Para que solo ocupe el espacio necesario
                children: [
                  Image.asset('assets/tlf.webp', width: 100, height: 100),
                  const SizedBox(height: 8),  // Espacio entre la imagen y el texto
                  const Text(
                    "Teléfono 1",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          // Segunda fila con dos columnas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/tlf.webp', width: 100, height: 100),
                  const SizedBox(height: 8),
                  const Text(
                    "Teléfono 2",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/tlf.webp', width: 100, height: 100),
                  const SizedBox(height: 8),
                  const Text(
                    "Teléfono 3",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          // Tercera fila con tres columnas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/tlf.webp', width: 100, height: 100),
                  const SizedBox(height: 8),
                  const Text(
                    "Teléfono 4",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/tlf.webp', width: 100, height: 100),
                  const SizedBox(height: 8),
                  const Text(
                    "Teléfono 5",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/tlf.webp', width: 100, height: 100),
                  const SizedBox(height: 8),
                  const Text(
                    "Teléfono 6",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
