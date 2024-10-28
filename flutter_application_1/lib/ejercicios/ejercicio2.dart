import 'package:flutter/material.dart';

class Ejercicio2 extends StatelessWidget {
  const Ejercicio2({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        
        title: const Text("Ejercicio 2. 3 Fotos en miniatura dispuestas en fila"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/image.png", fit: BoxFit.cover),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/image.png", fit: BoxFit.cover),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/image.png", fit: BoxFit.cover),
              ),
            ],
          ),
          
          // Espacio entre la fila y la columna
          const SizedBox(height: 20),

          
        ],
      ),
    );
  }
}
