import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/pantallas/drawerInicio.dart';

class PantallaCarga extends StatelessWidget {
  const PantallaCarga({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Drawerinicio()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Image.asset("assets/logo.png",height: 100,width: 100,),           

            const Text("GuardaTusVuelosHD"),
            const Text("Cargando..."), 
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
