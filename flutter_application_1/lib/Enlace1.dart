import 'package:flutter/material.dart';
import 'menulateral.dart';
import 'package:google_fonts/google_fonts.dart';

class Enlace1 extends StatelessWidget {
  const Enlace1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Primera pantalla"),
      ),
      drawer: const MenuLateral(),
      body: Center(
        child: Text("Contenido",
            style: GoogleFonts.acme(color: Colors.amber, fontSize: 45)),
      ),
    );
  }
}
