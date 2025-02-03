import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/model/flight.dart';

class Pantallavuelosguardados extends StatefulWidget {
  const Pantallavuelosguardados({super.key});

  @override
  PantallavuelosguardadosState createState() =>
      PantallavuelosguardadosState();

  
}

class PantallavuelosguardadosState extends State<Pantallavuelosguardados> {
   late Future<List<Flight>> favoritos;

  @override
  void initState() {
    super.initState();
    favoritos= Flight.getFavoritos();   
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
              FutureBuilder<List<Flight>>(
                future: favoritos,
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar los vuelos'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No tienes vuelos guardados'));
                } else {
                  return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final flight = snapshot.data![index];
                    return Card(
                    child: ListTile(
                        title: Text(favoritos.toString().substring(1, favoritos.toString().toLowerCase()  .length - 1)),
                      subtitle: Text('Fecha: ${flight.horaSalida}'),
                    ),
                    );
                  },
                  );
                }
                },
              ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
