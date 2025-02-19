import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/drawer.dart';

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
  final _formKey = GlobalKey<FormState>();

  bool _tieneHijos = false;
  bool _formulario = false;

  // Variables para la ciudad y el sexo
  String? _ciudadSeleccionada;
  String? _sexoSeleccionado;
  final List<String> _aficionesSeleccionadas = [];
  int ?_numeroHijos;
  // Lista de ciudades de Andalucía
  final List<String> _ciudadesAndalucia = [
    'Sevilla',
    'Málaga',
    'Córdoba',
    'Granada',
    'Jaén',
    'Almería',
    'Cádiz',
    'Huelva',
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
        _fechaController.text =
            "${picked.toLocal()}".split(' ')[0]; // Formato: yyyy-mm-dd
      });
    }
  }

  void _verificoForm() {
    // Verifico si el formulario es válido
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario enviado con éxito')),
       
      );
      if(!_formulario){
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Nombre: ${_nombreController.text}\n"
                "Correo: ${_correoController.text}\n"
                "Teléfono: ${_telefonoController.text}\n"             
                "Hijos: $_numeroHijos\n"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cerrar"),
              ),
            ],
          );
        },
      );
      }else{
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Fecha de nacimiento: ${_fechaController.text}\n"
                "Ciudad: $_ciudadSeleccionada\n"
                "Aficiones: ${_aficionesSeleccionadas.join(", ")}\n"
                "Sexo: $_sexoSeleccionado\n"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cerrar"),
              ),
            ],
          );
        },
      );
      }
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario no enviado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuLateral(),
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: _verificoForm, child: const Text("Enviar")),
                      ],
                    ),
                  ),
                ],
                if (!_formulario) ...[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Por favor ingresa un correo válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _telefonoController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Teléfono",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu teléfono';
                            }
                            if (!RegExp(r'^[0-9]{9}$').hasMatch(value)) {
                              return 'Por favor ingresa un teléfono válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // hijos
                        SwitchListTile(
                          title: const Text("¿Tienes hijos?"),
                          value: _tieneHijos,
                          onChanged: (bool value) {
                            setState(() {
                              _tieneHijos = value;
                              if (value) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Número de hijos"),
                                      content: DropdownButton<int>(
                                        items: List.generate(10, (index) {
                                          return DropdownMenuItem<int>(
                                            value: index + 1,
                                            child: Text((index + 1).toString()),
                                          );
                                        }),
                                        onChanged: (int? newValue) {
                                          setState(() {
                                            _numeroHijos = newValue;
                                            
                                          });
                                          Navigator.of(context).pop();
                                          
                                        },
                                        
                                      ),
                                    );
                                  },
                                );
                              }
                            });
                          },
                          
                        ),
                         if (_numeroHijos != null) 
                           Text("Número de hijos: $_numeroHijos"),

                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: _verificoForm, child: const Text("Enviar")),
                      ],
                    ),
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