import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/api/api_app.dart';

class Pantallabusqueda extends StatefulWidget {
  const Pantallabusqueda({super.key});

  @override
  PantallabusquedaState createState() => PantallabusquedaState();
}

class PantallabusquedaState extends State<Pantallabusqueda> {
  DateTime fechaSalida = DateTime.now();
  DateTime? fechaVuelta;
  int numeroPersonas = 1;
  bool soloIda = false;
  String origen = '';
  String destino = '';

  // Controladores de texto
  TextEditingController controladorOrigen = TextEditingController();
  TextEditingController controladorDestino = TextEditingController();

  
  String resultados = "";

  // Instancia de la API
  ApiAPP skyscannerAPI = ApiAPP();

  // Función para seleccionar la fecha
  Future<void> _seleccionarFecha(BuildContext context, bool esFechaSalida) async {
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

  // Función de búsqueda
  void _buscarVuelos() {
    setState(() {
      origen = controladorOrigen.text;
      destino = controladorDestino.text;
      
      resultados = 'Buscando vuelos...\n'
          'Origen: $origen\n'
          'Destino: $destino\n'
          'Fecha de salida: ${fechaSalida.toLocal()}\n'
          'Fecha de vuelta: ${fechaVuelta?.toLocal() ?? 'No seleccionada'}\n'
          'Número de personas: $numeroPersonas';
    });
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
                        items: List.generate(10, (index) => index + 1)
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
                        backgroundColor: Colors.blue[600],
                      ),
                      child: const Text('Buscar'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Mostrar resultados
                if (resultados.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: const Color.fromARGB(255, 165, 196, 226),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(resultados, style: const TextStyle(fontSize: 18)),
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
