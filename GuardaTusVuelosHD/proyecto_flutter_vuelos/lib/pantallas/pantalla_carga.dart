import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/pantallas/drawer_inicio.dart';

class PantallaCarga extends StatelessWidget {
  const PantallaCarga({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const Drawerinicio()),
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[50]!, 
              Colors.white, 
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             Image.asset(
                "assets/logo.png", 
                width: 250, 
                height: 290,
              ),
                            const SizedBox(height: 20),

              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}
