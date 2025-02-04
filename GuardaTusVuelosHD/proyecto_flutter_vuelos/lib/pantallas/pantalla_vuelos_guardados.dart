import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/model/flight.dart';
import 'package:proyecto_flutter_vuelos/persistencia/base_de_datos.dart'; // Import DatabaseHelper

class Pantallavuelosguardados extends StatefulWidget {
  const Pantallavuelosguardados({super.key});

  @override
  PantallavuelosguardadosState createState() => PantallavuelosguardadosState();
}

class PantallavuelosguardadosState extends State<Pantallavuelosguardados> {
  late Future<List<Flight>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = DatabaseHelper.instance.getFavorites(); // Cargar favoritos al iniciar
  }

  // Método para eliminar un vuelo de favoritos
  void _eliminarFavorito(Flight vuelo) async {
    if (vuelo.id != null) {
      await DatabaseHelper.instance.deleteFavorite(vuelo.id!); // Eliminar de la base de datos
      setState(() {
        _favoritesFuture = DatabaseHelper.instance.getFavorites(); // Actualizar la lista
      });
    }
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
                Center(
                  child: const Text(
                  'Tus vuelos guardados' ,
                  style: TextStyle(fontSize: 20),
                ),
                ),
                
                const SizedBox(height: 20),
                FutureBuilder<List<Flight>>(
                  future: _favoritesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error al cargar los vuelos'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No tienes vuelos guardados'));
                    } else {
                      final favoritos = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: favoritos.length,
                        itemBuilder: (context, index) {
                          final flight = favoritos[index];
                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Icon(
                                Icons.flight_takeoff,
                                color: Colors.blue,
                                size: 40,
                              ),
                              title: Text(
                                '${flight.aeropuertoOrigen} → ${flight.aeropuertoDestino}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hora de salida: ${flight.horaSalida}'),
                                  Text('Hora de llegada: ${flight.horaLlegada}'),
                                  const SizedBox(height: 8),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _eliminarFavorito(flight); // Eliminar de favoritos
                                },
                              ),
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