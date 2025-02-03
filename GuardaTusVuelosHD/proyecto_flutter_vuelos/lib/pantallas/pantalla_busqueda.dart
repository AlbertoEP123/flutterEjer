import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/api/api_app.dart';
import 'package:proyecto_flutter_vuelos/model/flight.dart';
import 'package:proyecto_flutter_vuelos/persistencia/base_de_datos.dart';

class Pantallabusqueda extends StatefulWidget {
  const Pantallabusqueda({super.key});

  @override
  PantallabusquedaState createState() => PantallabusquedaState();
}


class PantallabusquedaState extends State<Pantallabusqueda> {
  // variables
  late Future<List<Flight>> resultados;
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
    resultados = Future.value([]);
  }

  // actualizar texto de origen
  void _updateOrigenText(String text) {
    final codigo = ApiApp.obtenerCodigoA(text.toUpperCase()) ?? text;
    controladorOrigen.value = TextEditingValue(
      text: codigo,
      selection: TextSelection.collapsed(offset: codigo.length),
    );
  }

  // actualizar texto de destino
  void _updateDestinoText(String text) {
    final codigo = ApiApp.obtenerCodigoA(text.toUpperCase()) ?? text;
    controladorDestino.value = TextEditingValue(
      text: codigo,
      selection: TextSelection.collapsed(offset: codigo.length),
    );
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
void _toggleFavorite(int index, Flight flight) async {
  final dbHelper = DatabaseHelper.instance;

  try {
    // Realizar la operación asíncrona primero
    if (favoriteStatus[index] ?? false) {
      // Si ya es favorito, lo eliminamos
      if (flight.id != null) {
        await dbHelper.deleteFavorite(flight.id!);
      }
    } else {
      // Si no es favorito, lo agregamos
      await dbHelper.insertFavorite(flight.toMap());
    }

    // Luego, actualizar el estado de la interfaz de usuario
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
        resultados =
        // metodo que busca vuelos en la api
        
             ApiApp.fetchFlights(controladorOrigen.text.toUpperCase(), controladorDestino.text.toUpperCase(), fechaSalida, fechaVuelta, soloIda ? 2 : 1, numeroPersonas);
           
      });
    } catch (e) {
      ScaffoldMessenger.of(context)

          .showSnackBar(SnackBar(content: Text('Error: $e')));
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
          // Padding para ellogo
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
                  height: 120,                
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(height: 20),

                // Campo de origen
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controladorOrigen,
                        onChanged: (text) {
                          setState(() {
                            _updateOrigenText(text);
                          });
                        },
                        // Convierte el texto a mayúsculas
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
                    // campo de destino
                    Expanded(
                      child: TextField(
                        controller: controladorDestino,
                        onChanged: (text) {
                          setState(() {
                            _updateDestinoText(text);
                          });
                        },
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
                    // Si está cargando, muestra un indicador de progreso
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        // Para que el ListView no ocupe más espacio del necesario
                        shrinkWrap: true,
                        // Número de elementos en la lista
                        itemCount: snapshot.data!.length,
                        // Constructor de cada elemento de la lista
                        itemBuilder: (context, index) {
                          final flight = snapshot.data![index];

                          // Obtener el estado favorito de este vuelo
                          bool isFavorite = favoriteStatus[index] ?? false;
                          // Construir el elemento de la lista
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
                                      setState(() =>
                                        _toggleFavorite(index, flight)
                                      );
                                    
                                        
                                            
                                     
                                    },
                                  ),
                                  Text("Precio: ${flight.precio} €"),
                                ],
                              ),
                             
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

