import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:proyecto_flutter_vuelos/api/api_app.dart';
import 'package:proyecto_flutter_vuelos/model/flight.dart';

class Pantallabusqueda extends StatefulWidget {
  const Pantallabusqueda({super.key});

  @override
  PantallabusquedaState createState() => PantallabusquedaState();
}

class PantallabusquedaState extends State<Pantallabusqueda> {
  late Future<List<Flight>> resultados;
  Map<int, bool> favoriteStatus = {};
  Map<String, String> airportData = {};

  @override
  void initState() {
    super.initState();
    // _loadCsvData().then((data) {
    //   setState(() {
    //     airportData = data;
    //   });
    // });
    resultados = Future.value([]);
  }

  // Future<Map<String, String>> _loadCsvData() async {
  //   final rawData = await rootBundle.loadString('assets/airports.csv');
  //   List<List<dynamic>> listData =
  //       const CsvToListConverter(eol: '\n').convert(rawData);

  //   Map<String, String> data = {};
  //   for (int i = 1; i < listData.length; i++) {
  //     if (listData[i].length > 13) {
  //       String key = listData[i][10]?.toString() ?? '';
  //       String value = listData[i][13]?.toString() ?? '';
  //       if (key.isNotEmpty && value.isNotEmpty) {
  //         data[key] = value;
  //       }
  //     }
  //   }
  //   return data;
  // }

  DateTime fechaSalida = DateTime.now();
  DateTime? fechaVuelta;
  int numeroPersonas = 1;
  bool soloIda = false;

  TextEditingController controladorOrigen = TextEditingController();
  TextEditingController controladorDestino = TextEditingController();

  Future<void> _seleccionarFecha(
      BuildContext context, bool esFechaSalida) async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: esFechaSalida ? fechaSalida : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
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

  void _buscarVuelos() async {
    try {
      setState(() {
        resultados =
           ApiApp.fetchFlights(controladorOrigen.text, controladorDestino.text, fechaSalida, fechaVuelta!);
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
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

                // Campos de Origen y Destino
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controladorOrigen,
                        decoration: InputDecoration(
                          labelText: 'Origen',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: controladorDestino,
                        decoration: InputDecoration(
                          labelText: 'Destino',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
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
                      child: GestureDetector(
                        onTap: soloIda
                            ? null
                            : () => _seleccionarFecha(context, false),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Fecha de vuelta',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(fechaVuelta != null
                              ? '${fechaVuelta!.toLocal()}'.split(' ')[0]
                              : 'Selecciona la fecha'),
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
                          if (!soloIda) {
                            fechaVuelta = null;
                          }
                          
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
                    const SizedBox(width: 8),
                    ElevatedButton(
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

                // Mostrar los resultados
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

                          // Obtener el estado favorito de este vuelo
                          bool isFavorite = favoriteStatus[index] ?? false;

                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Icon(Icons.flight_takeoff,
                                  color: Colors.blue, size: 40),
                              title: Text(
                                  '${flight.aeropuertoOrigen} → ${flight.aeropuertoDestino}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hora de salida: ${flight.horaSalida}'),
                                  Text(
                                      'Hora de llegada: ${flight.horaLlegada}'),
                                  SizedBox(height: 8),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: isFavorite
                                          ? Colors.red
                                          : Colors.grey, // Cambia de color
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        favoriteStatus[index] =
                                            !isFavorite; // Cambiar el estado del favorito para este vuelo
                                      });
                                    },
                                  ),
                                ],
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.blue),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No se encontraron vuelos.'));
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

