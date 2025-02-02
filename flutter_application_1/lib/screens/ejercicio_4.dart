import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/drawer.dart';


// ignore: camel_case_types
class Ejercicio4 extends StatelessWidget {
  const Ejercicio4({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicio 4. Mostar 5 iconos"),
      ),
      drawer: MenuLateral(),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.home, size: 50),
            Icon(Icons.access_alarm_rounded, size: 50),
            Icon(Icons.account_tree_rounded, size: 50),
            Icon(Icons.settings, size: 50),
            Icon(Icons.youtube_searched_for_rounded, size: 50),
          ],
        ),
      ),
    );
  }
}
