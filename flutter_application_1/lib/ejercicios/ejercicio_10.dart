import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/drawer.dart';

class Ejercicio10 extends StatefulWidget {
  const Ejercicio10({super.key});

  @override
  State<Ejercicio10> createState() => Juego7y30();
}

class Juego7y30 extends State<Ejercicio10> {
  List<int> baraja = [1, 2, 3, 4, 5, 6, 7];
  int turno = 0;
  late int random;
  late int maquina = 0;
  late int usuario = 0;
  late int sumaMaquina = 0;
  late int sumaUsuario = 0;

  // Function que da carta random a los usuarios
  void darRandom1() {
    random = Random().nextInt(baraja.length);
    maquina = baraja[random];
    print('Maquina card: $maquina');
    sumaMaquina = maquina;
  }

  void darRandom2() {
    random = Random().nextInt(baraja.length);
    usuario = baraja[random];
    print('Usuario card: $usuario');
    sumaUsuario = usuario;
  }

  

  // void darRandom2SiQuiere() {
  //   random = Random().nextInt(baraja.length);
  //   usuario = baraja[random];
  // }



  void _iniciarJuego() {
    setState(() {
      while (maquina < 7 || usuario < 7) {
        darRandom1();
        darRandom2();
        turno++;
        break;
        
      }
      if (sumaMaquina == 7) {
        print("maquina gano");
      }
      if (sumaUsuario == 7) {
        print("usuario gano");
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
            Text('Tu carta es: $usuario'),
            Text('Carta maquina :  $maquina'),
            // ElevatedButton(
            //     onPressed: darRandom2SiQuiere,
            //     child: const Text("quiero otra")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _iniciarJuego,
              child: const Text('Iniciar Juego'),
            ),
            SizedBox(height: 25,),
            
          ],
        ),
      ),
    );
  }
}
