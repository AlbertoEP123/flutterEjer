import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class Pantallabusqueda extends StatefulWidget {
  const Pantallabusqueda({super.key});

  @override
  PantallabusquedaState createState() => PantallabusquedaState();
}

class PantallabusquedaState extends State<Pantallabusqueda> {
  late Future<List<Flight>> resultados;
  Map<String, String> airportData = {};
  @override
  void initState() {
    super.initState();
    _loadCsvData().then((data) {
      setState(() {
        airportData = data;
      });
    });
    resultados = Future.value([]); 
  }

 Future<Map<String, String>> _loadCsvData() async {


  // Cargar el archivo CSV como texto
  final rawData = await rootBundle.loadString('assets/airports.csv');

  
  
  List<List<dynamic>> listData = const CsvToListConverter(eol: '\n').convert(rawData);

  print("Número de filas: ${listData.length}");

  Map<String, String> data = {};
  for (int i = 1; i < listData.length; i++) {
    // Asegurarse de que cada fila tenga suficientes columnas
    if (listData[i].length > 13) {

      // Intentar obtener los valores de las columnas 10 y 13
      String key = listData[i][10]?.toString() ?? 'Clave no disponible';
      if(key.isEmpty){
        continue;
      }
      String value = listData[i][13]?.toString() ?? 'Valor no disponible';
      if(value.isEmpty){
        continue;
      }
   
      // Agregar los valores al mapa
      data[key] = value;
    } else {
      print("Fila $i tiene menos de 14 columnas.");
    }
  }

  return data;
}


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
      });

      // Obtener los códigos IATA de las ciudades de origen y destino
      // String ciudadOrigen = airportData[controladorOrigen.text]!;
      // String ciudadDestino = airportData[controladorDestino.text]!;
      // print(ciudadDestino);
      // print(ciudadOrigen);
      // Pasar los códigos IATA a la función para obtener los vuelos
      setState(() {
        resultados = fetchAlbum(controladorOrigen.text, controladorDestino.text);
      });
    } catch (e) {
      // Si hay un error (por ejemplo, ciudad no encontrada), mostrar un mensaje al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<String> _obtenerIATA(String ciudad) async {
    try {
      ciudad = ciudad.trim().toLowerCase();

      if (!airportData.containsKey(ciudad)) {
        throw Exception('Ciudad no encontrada');
      }
      var iataCode = airportData[ciudad]!;

    
      if (iataCode.isEmpty) {
        throw Exception('Código IATA no disponible para $ciudad');
      }

      return iataCode;
    } catch (e) {
      throw Exception('Error al obtener IATA para $ciudad: $e');
    }
  }

  Future<List<Flight>> fetchAlbum(
      String ciudadOrigen, String ciudadDestino) async {
    String url =
        "https://api.aviationstack.com/v1/flights?access_key=4af3d655ae1acbb6ec43c81b9a55d260&dep_iata=$ciudadOrigen&arr_iata=$ciudadDestino";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'] as List;
            print(response.body);
    
      List<Flight> vuelos = data.map((json) => Flight.fromJson(json)).toList();
      return vuelos;
    } else {
      throw Exception('Failed to load flights');
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
                // Logo
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
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Selección de fechas (Salida y Vuelta)
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
                          child: Text('${fechaSalida.toLocal()}'.split(' ')[0]), // Mostrar fecha de salida
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: soloIda ? null : () => _seleccionarFecha(context, false),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Fecha de vuelta',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(fechaVuelta != null ? '${fechaVuelta!.toLocal()}'.split(' ')[0] : 'Selecciona la fecha'),
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
                        backgroundColor: const Color.fromARGB(127, 30, 206, 229),
                      ),
                      child: const Text('Buscar'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: const Color.fromARGB(255, 165, 196, 226),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<List<Flight>>(
                        
                        future: resultados,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: snapshot.data!.map((flight) {
                                return Text(
                                  'Origen: ${flight.aeropuertoOrigen}\nDestino: ${flight.aeropuertoDestino} \nHora de salida: ${flight.horaSalida} \nHora de llegada: ${flight.horaLlegada}\n',
                                );
                              }).toList(),
                            );
                          } else {
                            return const Text('No se encontraron vuelos.');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Flight {
  final String? aeropuertoOrigen;
  final String? aeropuertoDestino;
  final String? horaSalida;
  final String? horaLlegada;

  const Flight({
    this.aeropuertoOrigen,
    this.aeropuertoDestino,
    this.horaSalida,
    this.horaLlegada,

  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      aeropuertoOrigen: json['departure']['airport'],
      aeropuertoDestino: json['arrival']['airport'],
      horaSalida: json['departure']['estimated'],
      horaLlegada: json['arrival']['estimated'],
    );
  }
}
