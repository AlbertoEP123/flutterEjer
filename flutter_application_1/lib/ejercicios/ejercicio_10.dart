import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/drawer.dart';

class Ejercicio10 extends StatefulWidget {
  const Ejercicio10({super.key});

  @override
  State<Ejercicio10> createState() => Juego7y30();
}

class Juego7y30 extends State<Ejercicio10> {
  List<int> baraja = [1, 2, 3, 4, 5, 6, 7, 11, 12, 13];
  int turno = 0;
  late int random;
  late int randomUser1 = 0;
  late int randomUser2 = 0;
  late int suma1 = 0;
  late int suma2 = 0;

  // Function que da carta random a los usuarios
  void darRandom1() {
    random = Random().nextInt(baraja.length);
    randomUser1 = baraja[random];
    print('User 1 card: $randomUser1');
    suma1 = randomUser1;
  }

  void darRandom2() {
    random = Random().nextInt(baraja.length);
    randomUser2 = baraja[random];
    print('User 2 card: $randomUser2');
    suma2 = randomUser2;
  }

  // void darRandom2SiQuiere() {
  //   random = Random().nextInt(baraja.length);
  //   randomUser2 = baraja[random];
  // }

  void _iniciarJuego() {
    setState(() {
      while (randomUser1 < 7 || randomUser2 < 7) {
        darRandom1();
        darRandom2();
        turno++;
        
      }
      if (suma1 == 7) {
          print("randomUser1 gano");
        }
        if (suma2 == 7) {
          print("randomUser2 gano");
        }
      print("juego acabado");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicio 10"),
      ),
      drawer: MenuLateral(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Turno: $turno',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text('Tu carta es: $randomUser2'),
            Text("Quieres otra?"),
            // ElevatedButton(
            //     onPressed: darRandom2SiQuiere,
            //     child: const Text("quiero otra")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _iniciarJuego,
              child: const Text('Iniciar Juego'),
            ),
          ],
        ),
      ),
    );
  }
}
