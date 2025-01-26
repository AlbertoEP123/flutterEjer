import 'package:flutter/material.dart';

class Pantallavuelosguardados extends StatelessWidget {
  const Pantallavuelosguardados({super.key});
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[50]!, Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
                Image.asset(
                  'assets/logo.png',  
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.fitHeight 
                ),
                const SizedBox(height: 20),

                const Text(
                  'Aquí aparecerán tus vuelos guardados',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
