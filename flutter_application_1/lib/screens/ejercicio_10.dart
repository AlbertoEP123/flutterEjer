import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/drawer.dart';

class Ejercicio10 extends StatefulWidget {
  const Ejercicio10({super.key});
  @override
  State<Ejercicio10> createState() => Juego7y30();
}

class Carta {
  // Atributas de la carta
  final String nombre;
  final double valor;
  final IconData icono;
  Carta({required this.nombre, required this.valor, required this.icono});
}

class Juego7y30 extends State<Ejercicio10> {
  // Baraja de cartas
  static final List<Carta> baraja = [
    Carta(nombre: 'As', valor: 1.0, icono: Icons.diamond),
    Carta(nombre: '2', valor: 2.0, icono: Icons.diamond),
    Carta(nombre: '3', valor: 3.0, icono: Icons.diamond),
    Carta(nombre: '4', valor: 4.0, icono: Icons.diamond),
    Carta(nombre: '5', valor: 5.0, icono: Icons.diamond),
    Carta(nombre: '6', valor: 6.0, icono: Icons.diamond),
    Carta(nombre: '7', valor: 7.0, icono: Icons.diamond),
    Carta(nombre: 'Sota', valor: 0.5, icono: Icons.diamond),
    Carta(nombre: 'Caballo', valor: 0.5, icono: Icons.diamond),
    Carta(nombre: 'Rey', valor: 0.5, icono: Icons.diamond),
  ];
  // Variables del juego
  Random random = Random();
  double maquina = 0.0;
  double usuario = 0.0;
  int victoriasUsuario = 0;
  int victoriasMaquina = 0;
  String mensaje = "";
  bool jugando = false;
  bool turnoJugadorActivo = false;
  bool turnoMaquinaActivo = false;
  int rondaActual = 0;
  List<Carta> cartasUsuario = [];
  List<Carta> cartasMaquina = [];

  //Metodo saca carta random
  Carta sacarCarta() {
    return baraja[random.nextInt(baraja.length)];
  }
  //Metodo para el turno del jugador
  void turnoJugador() {
    Carta carta = sacarCarta();
    setState(() {
      usuario += carta.valor;
      cartasUsuario.add(carta);
    });
  }
  //Metodo para el turno de la maquina
  void turnoMaquina() {
    Carta carta = sacarCarta();
    setState(() {
      maquina += carta.valor;
      cartasMaquina.add(carta);
    });
  }
  //Metodo para determinar el ganador
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
  //Metodo para iniciar el juego
  void _iniciarJuego() {
    setState(() {
      jugando = true;
      usuario = 0.0;
      maquina = 0.0;
      turnoJugadorActivo = true;
      turnoMaquinaActivo = false;
      mensaje = "Elige si quieres pedir carta o plantarte";
      cartasUsuario.clear();
      cartasMaquina.clear();
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
      _turnoMaquinaAutomatico();
    }
  }

  void _turnoMaquinaAutomatico() {
    // Simula el tiempo que tarda la máquina en decidir
    Future.delayed(const Duration(seconds: 1), () {
      // La máquina pide carta si tiene menos de 6.5 puntos
      if (maquina < 6.5) {
        turnoMaquina();
        _turnoMaquinaAutomatico();
      } else {
        // La máquina se planta si tiene 6.5 o más 
        setState(() {
          turnoMaquinaActivo = false;
          _determinarGanador();
          rondaActual++;
          if (rondaActual < 5) {
            _iniciarJuego();
          } else {
            jugando = false;
            mensaje =
                "Fin del juego. Victorias: Jugador $victoriasUsuario, Máquina $victoriasMaquina";
          }
        });
      }
    });
  }
  
  void _reiniciarJuego() {
    setState(() {
      victoriasUsuario = 0;
      victoriasMaquina = 0;
      mensaje = "El juego ha sido reiniciado";
      jugando = false;
      rondaActual = 0;
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
            Text('Ronda ${rondaActual + 1} de 5',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text('Puntaje del Jugador: ${usuario.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.headlineMedium),
            Wrap(
              children: cartasUsuario
                  .map((carta) => Icon(carta.icono, size: 40))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Text('Puntaje de la Máquina: ${maquina.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.headlineMedium),
            Wrap(
              children: cartasMaquina
                  .map((carta) => Icon(carta.icono, size: 40))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Text(mensaje,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Text('Victorias del Jugador: $victoriasUsuario',
                style: Theme.of(context).textTheme.headlineSmall),
            Text('Victorias de la Máquina: $victoriasMaquina',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            if (!jugando)
              ElevatedButton(
                  onPressed: _iniciarJuego, child: const Text('Iniciar Juego'))
            else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                onPressed: turnoJugadorActivo
                    ? () {
                        turnoJugador();
                        setState(() {
                          mensaje = "Tu carta: $usuario puntos";
                        });
                      }
                    : null,
                child: const Text('Pedir Carta'),
              ),
              ElevatedButton(
                onPressed: turnoJugadorActivo ? _seguirOPlantarJugador : null,
                child: const Text('Plantarse'),
              ),
              ElevatedButton(
                  onPressed: _reiniciarJuego,
                  child: const Text('Reiniciar Juego')),
                ],
              ),
             
            ],
          ],
        ),
      ),
    );
  }
}
