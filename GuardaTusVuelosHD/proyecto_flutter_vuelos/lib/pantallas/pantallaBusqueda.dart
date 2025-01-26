import 'package:flutter/material.dart';

class Pantallabusqueda extends StatelessWidget {
  const Pantallabusqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Búsqueda de Vuelos"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campo de texto para el origen
                
                TextFormField(
                  decoration: const InputDecoration(
                    
                    labelText: 'Origen',
                    hintText: 'Ingresa el origen',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Campo de texto para el destino
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Destino',
                    hintText: 'Ingresa el destino',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Campo para seleccionar la fecha de salida
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      // Aquí puedes hacer algo con la fecha seleccionada, por ejemplo:
                      print("Fecha seleccionada: $picked");
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Fecha de salida',
                        hintText: 'Selecciona una fecha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Campo para seleccionar el número de pasajeros
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Número de pasajeros',
                    hintText: 'Ingresa el número de pasajeros',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Botón para realizar la búsqueda
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Aquí va la lógica de búsqueda de vuelos
                      print("Realizando la búsqueda...");
                    },
                    child: const Text('Buscar vuelos'),
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
