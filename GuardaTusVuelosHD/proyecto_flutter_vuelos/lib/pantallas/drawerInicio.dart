import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantallaBusqueda.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantallaConfiguracion.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantallaVuelosGuardados.dart';

class Drawerinicio extends StatefulWidget {
  const Drawerinicio({super.key});

  @override
  _DrawerinicioState createState() => _DrawerinicioState();
}

class _DrawerinicioState extends State<Drawerinicio> {
  int _selectedIndex = 0;

  // Lista de pantallas que se mostrarán según la selección
  static const List<Widget> _screens = <Widget>[
    Pantallabusqueda(),
    Pantallavuelosguardados(),
    Pantallaconfiguracion()
  ];

  // Cambiar la pantalla seleccionada al hacer tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtener dimensiones de la pantalla (screenWidth se sigue usando)
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomNavHeight = 70.0; // Altura estimada de la barra inferior

    return Scaffold(
      body: Column(
        children: [
          // Asegurarse de que la pantalla seleccionada se ajuste correctamente
          Expanded(
            child: _screens[_selectedIndex], // Mostrar la pantalla seleccionada
          ),
        ],
      ),

      // El Drawer Inferior estará aquí, fijo en la parte inferior
      bottomNavigationBar: Container(
        color: Colors.blue[50], // Color de fondo del Drawer Inferior
        height: bottomNavHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1, // Ajustar el padding horizontal dinámicamente
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribuir las opciones equitativamente
            children: [
              // Opción: Búsqueda
              GestureDetector(
                onTap: () {
                  _onItemTapped(0); // Selecciona la pantalla de Búsqueda
                },
                child: SizedBox(  // Usamos un Container con tamaño explícito
                  width: screenWidth * 0.25, // Ajustamos el ancho para que sea apropiado
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.search, size: 30, color: Colors.blue), // Ícono de Búsqueda
                      Text("Búsqueda", style: TextStyle(color: Colors.blue)), // Texto
                    ],
                  ),
                ),
              ),
              // Opción: Vuelos Guardados
              GestureDetector(
                onTap: () {
                  _onItemTapped(1); // Selecciona la pantalla de Vuelos Guardados
                },
                child: SizedBox(  // Usamos un Container con tamaño explícito
                  width: screenWidth * 0.25, // Ajustamos el ancho para que sea apropiado
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.bookmark, size: 30, color: Colors.blue), // Ícono de Vuelos Guardados
                      Text("Guardados", style: TextStyle(color: Colors.blue)), // Texto
                    ],
                  ),
                ),
              ),
              // Opción: Configuración
              GestureDetector(
                onTap: () {
                  _onItemTapped(2); // Selecciona la pantalla de Configuración
                },
                child: SizedBox(  // Usamos un Container con tamaño explícito
                  width: screenWidth * 0.25, // Ajustamos el ancho para que sea apropiado
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.settings, size: 30, color: Colors.blue), // Ícono de Configuración
                      Text("Configuración", style: TextStyle(color: Colors.blue)), // Texto
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
