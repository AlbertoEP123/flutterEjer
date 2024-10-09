import 'package:flutter/material.dart';
import 'menulateral.dart';
import 'package:google_fonts/google_fonts.dart';

class Ejercicio2 extends StatelessWidget {
  const Ejercicio2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicio 2. 3 Fotos en miniatura en fila"),
      ),
      drawer: const MenuLateral(),
      body: Center(
        child: Text("Contenido",
            style: GoogleFonts.acme(color: Colors.amber, fontSize: 45)),
      ),
    );
  }
}
