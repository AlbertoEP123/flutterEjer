import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/model/flight.dart';
import 'package:proyecto_flutter_vuelos/persistencia/base_de_datos.dart';

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
    _favoritesFuture = DatabaseHelper.instance.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Flight>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tienes vuelos guardados'));
          } else {
            final favoritos = snapshot.data!;
            return ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final flight = favoritos[index];
                return ListTile(
                  title: Text('${flight.aeropuertoOrigen} → ${flight.aeropuertoDestino}'),
                  subtitle: Text('Precio: ${flight.precio} €'),
                );
              },
            );
          }
        },
      ),
    );
  }
}