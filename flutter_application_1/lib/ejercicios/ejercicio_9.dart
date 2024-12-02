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
  late Timer _imagenTimer;
  bool _juegoActivo = false; 

  // Función que inicia el juego
  void _iniciarJuego() {
    setState(() {
      _puntos = 10;
      _juegoActivo = true;
    });
    _mostrarImagenAleatoria();
    _iniciarTemporizador();
  }

  // Función que muestra una imagen en una posición aleatoria
  void _mostrarImagenAleatoria() {
    if (_imagenVisible) return; // Evita que se muestre dos veces seguidas

    setState(() {
      _imagenVisible = true;
      _posX = _aleatorio.nextDouble() * 200;
      _posY = _aleatorio.nextDouble() * 600;
    });

    // Eliminar la imagen después de un tiempo
    _imagenTimer = Timer(const Duration(seconds: 1), () {
      if (mounted && _imagenVisible) { // Verifica que el widget aún está montado
        setState(() {
          _imagenVisible = false;
          
          if (_puntos > 2) {
            _puntos -= 2;
          } else {
            _puntos = 0;  
          }
        });
        _mostrarSnackBar('-2 Puntos');
      }
    });
  }

  void _iniciarTemporizador() {
    _temporizador = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted && _puntos > 0) {
        _mostrarImagenAleatoria(); // Si el puntaje es mayor que 0, seguir mostrando imágenes
      } else {
        _temporizador.cancel(); // Detengo el temporizador cuando los puntos sean 0
        if (mounted) {
          _mostrarFinDeJuegoDialog();
        }
      }
    });
  }

  // Evento de presionar la imagen
  void _presionarImagen() {
    if (_imagenVisible) {
      setState(() {
        _puntos += 1; // Sumar 1 punto si es pulsado
        _imagenVisible = false; // Esconde la imagen al presionar
      });
      _mostrarSnackBar('+1 Punto');
    }
  }

  // Metodo SnackBar
  void _mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensaje),
      duration: const Duration(seconds: 1),
    ));
  }

  // Mostrar un AlertDialog cuando el juego termina
  void _mostrarFinDeJuegoDialog() {
    setState(() {
      _juegoActivo = false; // Cambiar el estado del juego a inactivo cuando termina
    });
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game over :('),
          content: Text('Perdiste con: $_puntos puntos'),
          actions: <Widget>[
            TextButton(
              child: const Text('Reiniciar'),
              onPressed: () {
                Navigator.of(context).pop(); 
                _iniciarJuego(); 
              },
            ),
            TextButton(
              child: const Text('Salir'),
              onPressed: () {
                Navigator.of(context).pop(); 
                dispose(); 
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _temporizador.cancel();
    _imagenTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Imágenes en posición aleatoria')),
      drawer: const MenuLateral(),
      body: Stack(
        children: [
          if (_imagenVisible && _juegoActivo) // Si el juego está activo y la imagen es visible
            Positioned(
              top: _posY,
              left: _posX,
              child: GestureDetector(
                onTap: _presionarImagen,
                child: Image.asset('assets/image.png', width: 100, height: 100), // lo muestro
              ),
            ),
          // Mostrar puntos 
          Positioned(
            top: 50,
            left: 20,
            child: Text('Puntos: $_puntos', style: const TextStyle(fontSize: 24)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _iniciarJuego, // Llama a _iniciarJuego cuando se presiona
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
