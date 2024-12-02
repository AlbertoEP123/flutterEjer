import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/drawer.dart';

class Ejercicio10 extends StatefulWidget {
  const Ejercicio10({super.key});
  @override
  State<Ejercicio10> createState() => Juego7y30();
}

class Carta {
  final String nombre;
  final double valor;
  Carta({required this.nombre, required this.valor});
}

class Juego7y30 extends State<Ejercicio10> {
  static final List<Carta> baraja = [
    Carta(nombre: 'As', valor: 1.0),
    Carta(nombre: '2', valor: 2.0),
    Carta(nombre: '3', valor: 3.0),
    Carta(nombre: '4', valor: 4.0),
    Carta(nombre: '5', valor: 5.0),
    Carta(nombre: '6', valor: 6.0),
    Carta(nombre: '7', valor: 7.0),
    Carta(nombre: 'Sota', valor: 0.5),
    Carta(nombre: 'Caballo', valor: 0.5),
    Carta(nombre: 'Rey', valor: 0.5),
  ];

  Random random = Random();
  double maquina = 0.0;
  double usuario = 0.0;
  int victoriasUsuario = 0;
  int victoriasMaquina = 0;
  String mensaje = "";
  bool jugando = false;
  bool turnoJugadorActivo = false;
  bool turnoMaquinaActivo = false;

  Carta sacarCarta() {
    return baraja[random.nextInt(baraja.length)];
  }

  void turnoJugador() {
    setState(() {
      usuario += sacarCarta().valor;
    });
  }

  void turnoMaquina() {
    setState(() {
      maquina += sacarCarta().valor;
    });
  }

  void _determinarGanador() {
    if (usuario > 7.5) {
      setState(() {
        mensaje = "Te has pasado, la máquina gana";
        victoriasMaquina++;
      });
    } else if (maquina > 7.5) {
      setState(() {
        mensaje = "La máquina se ha pasado, tu ganas";
        victoriasUsuario++;
      });
    } else if (usuario > maquina) {
      setState(() {
        mensaje = "Ganas la partida con $usuario puntos";
        victoriasUsuario++;
      });
    } else if (usuario < maquina) {
      setState(() {
        mensaje = "La máquina gana la partida con $maquina puntos";
        victoriasMaquina++;
      });
    } else {
      setState(() {
        mensaje = "Empate a $usuario puntos";
      });
    }
  }

  void _iniciarJuego() {
    setState(() {
      jugando = true;
      usuario = 0.0;
      maquina = 0.0;
      turnoJugadorActivo = true;
      turnoMaquinaActivo = false;
      mensaje = "Elige si quieres pedir carta o plantarte";
    });
  }

  void _seguirOPlantarJugador() {
    if (usuario > 7.5) {
      setState(() {
        mensaje = "Te has pasado, la máquina gana esta partida.";
        victoriasMaquina++;
        jugando = false;
      });
    } else {
      setState(() {
        turnoJugadorActivo = false;
        turnoMaquinaActivo = true;
        mensaje = "Es el turno de la máquina.";
      });
    }
  }

  void _seguirOPlantarMaquina() {
    if (maquina > 7.5) {
      setState(() {
        mensaje = "La máquina se ha pasado, ganas la partida";
        victoriasUsuario++;
        jugando = false;
      });
    } else if (maquina >= 6.5) {
      setState(() {
        turnoMaquinaActivo = false;
        _determinarGanador();
      });
    } else {
      turnoMaquina();
      if (maquina > 7.5) {
        setState(() {
          mensaje = "La máquina se ha pasado, ganas la partida";
          victoriasUsuario++;
          jugando = false;
        });
      }
    }
  }

  void _reiniciarJuego() {
    setState(() {
      victoriasUsuario = 0;
      victoriasMaquina = 0;
      mensaje = "El juego ha sido reiniciado";
      jugando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ejercicio 10 - 7 y Medio")),
      drawer: MenuLateral(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Puntaje del Jugador: ${usuario.toStringAsFixed(1)}', style: Theme.of(context).textTheme.headlineMedium),
            Text('Puntaje de la Máquina: ${maquina.toStringAsFixed(1)}', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text(mensaje, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Text('Victorias del Jugador: $victoriasUsuario', style: Theme.of(context).textTheme.headlineSmall),
            Text('Victorias de la Máquina: $victoriasMaquina', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            if (!jugando)
              ElevatedButton(onPressed: _iniciarJuego, child: const Text('Iniciar Juego'))
            else ...[
              ElevatedButton(
                onPressed: turnoJugadorActivo ? () { turnoJugador(); setState(() { mensaje = "Tu carta: $usuario puntos"; }); } : null,
                child: const Text('Pedir Carta'),
              ),
              ElevatedButton(
                onPressed: turnoJugadorActivo ? _seguirOPlantarJugador : null,
                child: const Text('Plantarse'),
              ),
              if (turnoMaquinaActivo)
                ElevatedButton(
                  onPressed: _seguirOPlantarMaquina,
                  child: const Text('Turno maquina'),
                ),
              ElevatedButton(onPressed: _reiniciarJuego, child: const Text('Reiniciar Juego')),
            ],
          ],
        ),
      ),
    );
  }
}
