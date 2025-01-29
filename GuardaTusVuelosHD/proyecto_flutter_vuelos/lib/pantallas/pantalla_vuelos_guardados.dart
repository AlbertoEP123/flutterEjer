import 'package:flutter/material.dart';

class Pantallavuelosguardados extends StatefulWidget {
  const Pantallavuelosguardados({super.key});

  @override
  _PantallavuelosguardadosState createState() =>
      _PantallavuelosguardadosState();
}

class _PantallavuelosguardadosState extends State<Pantallavuelosguardados> {
  late Future<List<Map<String, dynamic>>> favoritos;

  @override
  void initState() {
    super.initState();
    //favoritos = DatabaseHelper.instance.queryAllFavorites(); // Obtenemos los favoritos
  }

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
                  height: 120,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Aquí aparecerán tus vuelos guardados',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),

              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
