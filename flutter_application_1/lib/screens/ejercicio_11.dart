import 'dart:ui';
import 'dart:math'; // Importamos Random
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/drawer.dart';

class Ejercicio11 extends StatefulWidget {
  const Ejercicio11({super.key});

  @override
  State<Ejercicio11> createState() => _FormularioState();
}

class _FormularioState extends State<Ejercicio11> {
  // GlobalKey para el Form
  final _formKey = GlobalKey<FormState>();

  // Controladores de los campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _fechaSeleccionada;

  // Variables para adivinar el número
  final Random _random = Random();
  late int _numeroSecreto;
  final TextEditingController _numeroController = TextEditingController();
  String _mensaje = '';

  @override
  void initState() {
    super.initState();
    _numeroSecreto = _random.nextInt(100) + 1; // Genero un número entre 1 y 100
  }

  void _verificoForm() {
    // Verifico si el formulario es válido
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario enviado con éxito')),
      );
    }
  }
  

  // Método para seleccionar la fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  void _validarNumero() {
    // Convierto text a num
    final int? numero = int.tryParse(_numeroController.text);

    if (numero == null) {
      setState(() {
        _mensaje = 'Ingresa un número válido.';
      });
    } else if (numero < _numeroSecreto) {
      setState(() {
        _mensaje = 'El número es mayor que $numero.';
      });
    } else if (numero > _numeroSecreto) {
      setState(() {
        _mensaje = 'El número es menor que $numero.';
      });
    } else {
      setState(() {
        _mensaje = '¡Felicidades! Adivinaste el número.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: const Text('Ejercicio 11 - Formularios'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Formulario Principal
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Formulario Principal',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Campo para el nombre
                        TextFormField(
                          controller: _nombreController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre',
                            hintText: 'Ingresa tu nombre',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu nombre';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Campo para la fecha
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: TextEditingController(
                                text: _fechaSeleccionada == null
                                    ? ''
                                    : _fechaSeleccionada!.toLocal().toString().split(' ')[0],
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Fecha de nacimiento',
                                hintText: 'Selecciona tu fecha',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (_fechaSeleccionada == null) {
                                  return 'Por favor selecciona una fecha';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Campo para el correo electrónico
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Correo electrónico',
                            hintText: 'Ingresa tu correo',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingresa un correo electrónico';
                            }
                            String expRegular = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                            RegExp regExp = RegExp(expRegular);
                            if (!regExp.hasMatch(value)) {
                              return 'Correo electrónico no válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Campo para la edad (solo numérico)
                        TextFormField(
                          controller: _edadController,
                          decoration: const InputDecoration(
                            labelText: 'Edad',
                            hintText: 'Ingresa tu edad',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu edad';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Edad no válida';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Campo para la ciudad
                        TextFormField(
                          controller: _ciudadController,
                          decoration: const InputDecoration(
                            labelText: 'Ciudad',
                            hintText: 'Ingresa tu ciudad',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu ciudad';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Campo para la contraseña
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Contraseña',
                            hintText: 'Ingresa tu contraseña',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.visibility_off),
                          ),
                          obscureText: true,
                          obscuringCharacter: '●',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa una contraseña';
                            }
                            if (value.length < 6) {
                              return 'La contraseña debe tener al menos 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Botón para enviar el formulario
                        ElevatedButton(
                          onPressed: _verificoForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          ),
                          child: const Text('Enviar', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Juego de Adivinar el Número
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Adivina el Número',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Adivina el número entre 1 y 100:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      // Campo de texto para el número
                      TextFormField(
                        controller: _numeroController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Introduce tu número',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa un número.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                        ElevatedButton(
                        onPressed: _validarNumero,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: const Text('Verificar', style: TextStyle(fontSize: 16)),
                        ),
                    
                    
                     
                      
                      const SizedBox(height: 20),
                      Text(
                        _mensaje,
                        style: TextStyle(
                          fontSize: 18,
                          color: _mensaje.startsWith('¡Felicidades') ? Colors.green : Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
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