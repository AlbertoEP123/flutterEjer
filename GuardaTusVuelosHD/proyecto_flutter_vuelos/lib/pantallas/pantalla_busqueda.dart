import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/api/api_app.dart';
import 'package:proyecto_flutter_vuelos/model/configuracion.dart';
import 'package:proyecto_flutter_vuelos/model/flight.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantalla_configuracion.dart';
import 'package:proyecto_flutter_vuelos/persistencia/base_de_datos.dart';
import 'package:proyecto_flutter_vuelos/persistencia/bd_configuracion.dart';

class Pantallabusqueda extends StatefulWidget {
  const Pantallabusqueda({super.key});

  @override
  PantallabusquedaState createState() => PantallabusquedaState();
}

class PantallabusquedaState extends State<Pantallabusqueda> {
  // variables
  static Future<List<Flight>> resultados = Future.value([]);
  Map<int, bool> favoriteStatus = {};
  Map<String, String> airportData = {};
  DateTime fechaSalida = DateTime.now();
  DateTime fechaVuelta = DateTime.now();
  int numeroPersonas = 1;
  bool soloIda = false;
  TextEditingController controladorOrigen = TextEditingController();
  TextEditingController controladorDestino = TextEditingController();

  // inicizalizo variable resultados
  @override
  void initState() {
    super.initState();
    updateFavoriteStatus();
    
  }

  void _updateOrigenText(String text) {
    try {
      final codigo = ApiApp.obtenerCodigoA(text) ?? text.toUpperCase();
      controladorOrigen.value = TextEditingValue(
        text: codigo,
        selection: TextSelection.collapsed(offset: codigo.length),
      );
    } catch (e) {
      print('Error en _updateOrigenText: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener código de aeropuerto: $e')),
      );
    }
  }

  void _updateDestinoText(String text) {
    try {
      final codigo = ApiApp.obtenerCodigoA(text) ?? text.toUpperCase();
      controladorDestino.value = TextEditingValue(
        text: codigo,
        selection: TextSelection.collapsed(offset: codigo.length),
      );
    } catch (e) {
      print('Error en _updateDestinoText: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener código de aeropuerto: $e')),
      );
    }
  }

  // seleccionar fecha
  Future<void> _seleccionarFecha(
      BuildContext context, bool esFechaSalida) async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: esFechaSalida ? fechaSalida : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    // metodo que actualiza la fecha
    if (fechaSeleccionada != null) {
      setState(() {
        if (esFechaSalida) {
          fechaSalida = fechaSeleccionada;
        } else {
          fechaVuelta = fechaSeleccionada;
        }
      });
    }
  }

  // Future<void> _cargarConfiguracion() async {
  //   try {
  //     final config = await BdConfiguracion.loadPreferences();
  //     if (mounted) {
  //       setState(() {
  //         configuracion = config;
  //       });
  //     }
  //   } catch (e) {
  //     print('Error cargando configuración: $e');
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error cargando configuración: $e')),
  //       );
  //     }
  //   }
  // }

  void updateFavoriteStatus() async {
    final flights = await resultados;
    for (int i = 0; i < flights.length; i++) {
      favoriteStatus[i] = await DatabaseHelper.instance.isFavorite(flights[i]);
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _toggleFavorite(int index, Flight flight) {
    final dbHelper = DatabaseHelper.instance;

    try {
      if (favoriteStatus[index] ?? false) {
        // Si ya es favorito, lo eliminamos
        if (flight.id != null) {
          dbHelper.deleteFavorite(flight.id!);
        }
      } else {
        // Si no es favorito, lo agregamos
        dbHelper.insertFavorite(flight.toMap());
      }

      // Luego, actualizar el estado de la interfaz de usuario (dentro de setState)
      setState(() {
        favoriteStatus[index] = !(favoriteStatus[index] ?? false);
      });
    } catch (e) {
      // Manejar el error (por ejemplo, mostrar un SnackBar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // metodo que busca vuelos con los parametros introducidos
  void _buscarVuelos() async {
    try {
      setState(() {
        resultados = ApiApp.fetchFlights(
            controladorOrigen.text.toUpperCase(),
            controladorDestino.text.toUpperCase(),
            fechaSalida,
            fechaVuelta,
            soloIda ? 2 : 1,
            numeroPersonas,
            PantallaConfiguracionState.moneda);
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error al buscar vuelos: $e')));
    }
  }

// metodo que construye la pantalla de busqueda
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // BoxDecoration para el gradiente de fondo
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[50]!, Colors.white],
            ),
          ),
          // Padding para el logo
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/logo.png',
                  // Ajusta la imagen al ancho de la pantalla
                  width: double.infinity,
                  height: 170,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(height: 20),

                // Campo de origen
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controladorOrigen,
                        onChanged: _updateOrigenText,
                        decoration: InputDecoration(
                          labelText: 'Origen',
                          hintText: 'Ciudad o código IATA',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: controladorDestino,
                        onChanged: _updateDestinoText,
                        decoration: InputDecoration(
                          labelText: 'Destino',
                          hintText: 'Ciudad o código IATA',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Selección de fechas
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _seleccionarFecha(context, true),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Fecha de salida',
                            border: OutlineInputBorder(),
                          ),
                          child: Text('${fechaSalida.toLocal()}'.split(' ')[0]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      // Si solo es ida, no se puede seleccionar la fecha de vuelta
                      child: GestureDetector(
                        onTap: soloIda
                            ? null
                            : () => _seleccionarFecha(context, false),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Fecha de vuelta',
                            border: OutlineInputBorder(),
                          ),
                          child: Text('${fechaVuelta.toLocal()}'.split(' ')[0]),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Selector para solo ida o ida y vuelta
                Row(
                  children: [
                    const Text('Ida y vuelta'),
                    Switch(
                      value: soloIda,
                      onChanged: (bool nuevoValor) {
                        setState(() {
                          soloIda = nuevoValor;
                        });
                      },
                    ),
                    const Text('Ida'),
                  ],
                ),

                const SizedBox(height: 20),

                // Número de personas y botón de búsqueda
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<int>(
                        value: numeroPersonas,
                        onChanged: (int? nuevoValor) {
                          setState(() {
                            numeroPersonas = nuevoValor!;
                          });
                        },
                        items: List.generate(8, (index) => index + 1)
                            .map<DropdownMenuItem<int>>((int valor) {
                          return DropdownMenuItem<int>(
                            value: valor,
                            child: Text('$valor personas'),
                          );
                        }).toList(),
                        isExpanded: false,
                        underline: Container(),
                      ),
                    ),
                    // Botón de búsqueda
                    const SizedBox(width: 8),
                    ElevatedButton(
                      // Llama al método de búsqueda
                      onPressed: _buscarVuelos,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(127, 30, 206, 229),
                      ),
                      child: const Text('Buscar'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // FutureBuilder para mostrar los resultados
                FutureBuilder<List<Flight>>(
                  future: resultados,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final flight = snapshot.data![index];
                          bool isFavorite = favoriteStatus[index] ?? false;

                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Icon(Icons.flight_takeoff,
                                  color: Colors.blue, size: 40),
                              title: Text(
                                '${flight.aeropuertoOrigen} → ${flight.aeropuertoDestino}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hora de salida: ${flight.horaSalida}'),
                                  Text(
                                      'Hora de llegada: ${flight.horaLlegada}'),
                                  const SizedBox(height: 8),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color:
                                          isFavorite ? Colors.red : Colors.grey,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(
                                          () => _toggleFavorite(index, flight));
                                    },
                                  ),
                                  Text(
                                      "Precio: ${flight.precio} ${flight.moneda}"),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                          child: Text('No se encontraron vuelos.'));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
