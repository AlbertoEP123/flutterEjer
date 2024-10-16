import 'package:flutter/material.dart';

class Ejercicio5 extends StatelessWidget {
  const Ejercicio5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicio 5. Ejercicio ejemplo resuelto"),
      ),
      body: Column(
        children: [
          // Encabezado
          Container(
            height: 130,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF57B3FC),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xAA6EB1E6),
                  offset: Offset(9, 9),
                  blurRadius: 6,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'I am a header',
              style: TextStyle(
                fontSize: 38,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 20), // Espacio entre el encabezado y los íconos

         
          
        ],
      ),
    );
  }
}
