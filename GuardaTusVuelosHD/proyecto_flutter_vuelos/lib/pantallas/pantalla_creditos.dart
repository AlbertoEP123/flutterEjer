import 'package:flutter/material.dart';

class PantallaCreditos extends StatefulWidget {
  const PantallaCreditos({super.key});

  @override
  PantallaCreditosState createState() => PantallaCreditosState();
}
// pantalla creditos sencilla

class PantallaCreditosState extends State<PantallaCreditos> {
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
                const SizedBox(height: 50),
                Image.asset(
                  'assets/logo.png',
                  width: double.infinity,
                  height: 170,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(height: 20),

                // Título 
                const Center(
                  child: Text(
                    'Créditos',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Créditos
                const Text(
                  'Desarrollado por:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Alberto Enrique Pulido',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                const Text(
                  'API Usada:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Google Flights: https://serpapi.com/google-flights-api',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Inspiración :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Skyscanner: https://www.skyscanner.es/',
                  style: TextStyle(fontSize: 16),
                ),
              

            
              ],
            ),
          ),
        ),
      ),
    );
  }
}