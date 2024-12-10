import 'dart:ui';
import 'dart:math'; // Importamos Random
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/drawer.dart';

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

  // Variables para  adivinar el número
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
        SnackBar(content: Text('Formulario enviado con éxito')),
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
        _mensaje = 'ingresa un número válido.';
      });
    } else if (numero < _numeroSecreto) {
      setState(() {
        _mensaje = 'El número es mayor que $numero.';
      });
    } else if (numero > _numeroSecreto) {
      setState(() {
        _mensaje = 'El número es menor que $numero. ';
      });
    } else {
      setState(() {
        _mensaje = 'Adivinaste el número.';
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
      body: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          // Formulario
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: 500,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey, // Asigno la GlobalKey al Form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Campo para el nombre
                      TextFormField(
                        controller: _nombreController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          hintText: 'Ingresa tu nombre',
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
                            decoration: InputDecoration(
                              labelText: 'Fecha de nacimiento',
                              hintText: _fechaSeleccionada == null
                                  ? 'Selecciona tu fecha'
                                  : _fechaSeleccionada!.toLocal().toString().split(' ')[0],
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
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ingresa un correo electrónico';
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
                          suffixIcon: Icon(Icons.visibility_off),
                        ),
                        obscureText: true, // Oculto el texto
                        obscuringCharacter: '●', // Carácter para ocultar la contraseña
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
                        child: const Text('Enviar'),
                      ),
                      const SizedBox(height: 20),
                      // Campo para adivinar el número
                      const Text(
                        'Adivina el número entre 1 y 100:',
                        style: TextStyle(fontSize: 20),
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
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _validarNumero();
                          }
                        },
                        child: const Text('Verificar'),
                      ),
                      const SizedBox(height: 20),
                     
                      Text(
                        _mensaje,
                        style: TextStyle(
                          fontSize: 18,
                          color: _mensaje.startsWith('¡Felicidades') ? const Color.fromARGB(255, 48, 250, 54) : Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
