import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/drawer.dart';
class JuegoAleatorioScreen extends StatefulWidget {
  const JuegoAleatorioScreen({super.key});

  @override
  JuegoAleatorioScreenState createState() => JuegoAleatorioScreenState();
}

class JuegoAleatorioScreenState extends State<JuegoAleatorioScreen> {
  int _puntos = 0;
  bool _imagenVisible = false;
  double _posX = 0.0, _posY = 0.0;
  final Random _aleatorio = Random();
  late Timer _temporizador;

  void _iniciarJuego() {
    _puntos = 0;
    _mostrarImagenAleatoria();
    _iniciarTemporizador();
  }

  void _mostrarImagenAleatoria() {
    setState(() {
      _imagenVisible = true;
      _posX = _aleatorio.nextDouble() * 800;
      _posY = _aleatorio.nextDouble() * 1200;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_imagenVisible) {
        setState(() {
          _imagenVisible = false;
          _puntos -= 2; // Penaliza si no se pulsa la imagen a tiempo
        });
      }
    });
  }

  void _iniciarTemporizador() {
    _temporizador = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_puntos == 0) _iniciarJuego();
    });
  }

  void _presionarImagen() {
    if (_imagenVisible) {
      setState(() {
        _puntos += 1; // Sumar puntos si se pulsa la imagen
        _imagenVisible = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _iniciarJuego();
  }

  @override
  void dispose() {
    _temporizador.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Juego Aleatorio')),
      drawer: MenuLateral(),
      body: Stack(
        children: [
          if (_imagenVisible)
            Positioned(
              top: _posY,
              left: _posX,
              child: GestureDetector(
                onTap: _presionarImagen,
                child: Image.asset('assets/image.png', width: 100, height: 100),
              ),
            ),
          Positioned(
            top: 50,
            left: 20,
            child: Text('Puntos: $_puntos', style: const TextStyle(fontSize: 24)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _iniciarJuego,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
