import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/model/flight.dart';
import 'package:proyecto_flutter_vuelos/persistencia/base_de_datos.dart'; 

class Pantallavuelosguardados extends StatefulWidget {
  final VoidCallback onFavoritesChanged;

  const Pantallavuelosguardados({super.key, required this.onFavoritesChanged});

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
      await DatabaseHelper.instance.deleteFavorite(vuelo.id!);
      setState(() {
        _favoritesFuture = DatabaseHelper.instance.getFavorites();
      });
      widget.onFavoritesChanged(); // Notificar que los favoritos han cambiado
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
                  height: 170,
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

                                   const SizedBox(height: 5),
                                  Text('Fecha salida: ${flight.horaSalida}h'),
                                  Text('Fecha llegada: ${flight.horaLlegada}h'),
                                  Text('Precio: ${flight.precio} ${flight.moneda}'),
                                  Text('Aerolinea: ${flight.aerolinea}'),
                                  Text('Clase del vuelo: ${flight.claseVuelo}'),
                                  Text('Duracion: ${flight.maxDuracion} min'),


                                  
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