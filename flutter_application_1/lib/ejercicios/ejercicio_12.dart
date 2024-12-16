import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/drawer.dart';

class Ejercicio12 extends StatefulWidget {
  const Ejercicio12({super.key});

  @override
  State<Ejercicio12> createState() => _FormularioStateSwitch();
}

class _FormularioStateSwitch extends State<Ejercicio12> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  
  bool _tieneHijos = false;
  bool _formulario = false;

  // Variables para la ciudad y el sexo
  String? _ciudadSeleccionada;
  String? _sexoSeleccionado;
  List<String> _aficionesSeleccionadas = [];

  // Lista de ciudades de Andalucía
  final List<String> _ciudadesAndalucia = [
    'Sevilla', 'Málaga', 'Córdoba', 'Granada', 'Jaén', 'Almería', 'Cádiz', 'Huelva', 'Cádiz'
  ];

  // Función para seleccionar la fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _fechaController.text = "${picked.toLocal()}".split(' ')[0]; // Formato: yyyy-mm-dd
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: const Text("Ejercicio 12 - Formulario switch"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: const Text("Elegir formulario"),
                  value: _formulario,
                  onChanged: (bool value) {
                    setState(() {
                      _formulario = value;
                    });
                  },
                ),
                if (_formulario) ...[
                  TextFormField(
                    controller: _fechaController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Fecha de nacimiento",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor selecciona una fecha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                
                  DropdownButtonFormField<String>(
                    value: _ciudadSeleccionada,
                    decoration: const InputDecoration(
                      labelText: "Ciudad de Andalucía",
                    ),
                    items: _ciudadesAndalucia.map((ciudad) {
                      return DropdownMenuItem<String>(
                        value: ciudad,
                        child: Text(ciudad),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _ciudadSeleccionada = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor selecciona una ciudad';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text("Aficiones:"),
                  CheckboxListTile(
                    title: const Text("Deportes"),
                    value: _aficionesSeleccionadas.contains("Deportes"),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          _aficionesSeleccionadas.add("Deportes");
                        } else {
                          _aficionesSeleccionadas.remove("Deportes");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Pertiga"),
                    value: _aficionesSeleccionadas.contains("Pertiga"),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          _aficionesSeleccionadas.add("Pertiga");
                        } else {
                          _aficionesSeleccionadas.remove("Pertiga");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Viajar"),
                    value: _aficionesSeleccionadas.contains("Viajar"),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          _aficionesSeleccionadas.add("Viajar");
                        } else {
                          _aficionesSeleccionadas.remove("Viajar");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Futbol"),
                    value: _aficionesSeleccionadas.contains("Futbol"),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          _aficionesSeleccionadas.add("Futbol");
                        } else {
                          _aficionesSeleccionadas.remove("Futbol");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Música"),
                    value: _aficionesSeleccionadas.contains("Música"),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          _aficionesSeleccionadas.add("Música");
                        } else {
                          _aficionesSeleccionadas.remove("Música");
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text("Sexo:"),
                  ListTile(
                    title: const Text("Hombre"),
                    leading: Radio<String>(
                      value: "Hombre",
                      groupValue: _sexoSeleccionado,
                      onChanged: (String? value) {
                        setState(() {
                          _sexoSeleccionado = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Mujer"),
                    leading: Radio<String>(
                      value: "Mujer",
                      groupValue: _sexoSeleccionado,
                      onChanged: (String? value) {
                        setState(() {
                          _sexoSeleccionado = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Prefiero no contestar"),
                    leading: Radio<String>(
                      value: "Prefiero no contestar",
                      groupValue: _sexoSeleccionado,
                      onChanged: (String? value) {
                        setState(() {
                          _sexoSeleccionado = value;
                        });
                      },
                    ),
                  ),
                ],
                if (!_formulario) ...[
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      labelText: "Nombre",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _correoController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Correo",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _telefonoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Teléfono",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu teléfono';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text("¿Tienes hijos?"),
                    value: _tieneHijos,
                    onChanged: (bool value) {
                      setState(() {
                        _tieneHijos = value;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
