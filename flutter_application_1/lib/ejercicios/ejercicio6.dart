import 'package:flutter/material.dart';



class Ejercicio6 extends StatelessWidget {
  const Ejercicio6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicio 6. Ejercicio telefonos"),
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Primera fila con una imagen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/tlf.webp', width: 100, height: 100),
              ],
            ),
            // Segunda fila con dos imágenes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/tlf.webp', width: 100, height: 100),
                Image.asset('assets/tlf.webp', width: 100, height: 100),
              ],
            ),
            // Tercera fila con tres imágenes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/tlf.webp', width: 100, height: 100),
                Image.asset('assets/tlf.webp', width: 100, height: 100),
                Image.asset('assets/tlf.webp', width: 100, height: 100),
              ],
            ),
          ],
        ),
      );
  }
}
    
