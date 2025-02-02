import 'package:flutter/material.dart';

import 'package:proyecto_flutter_vuelos/pantallas/pantalla_busqueda.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantalla_configuracion.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantalla_vuelos_guardados.dart';

class Drawerinicio extends StatefulWidget {
  const Drawerinicio({super.key});

  @override
  DrawerinicioState createState() => DrawerinicioState();
}
// drawer que contiene las opciones de búsqueda, vuelos guardados y configuración
class DrawerinicioState extends State<Drawerinicio> {
  // Índice de la pantalla seleccionada
  int _selectedIndex = 0;

  // Lista de pantallas        
  static const List<Widget> _screens = <Widget>[
    Pantallabusqueda(),
    Pantallavuelosguardados(),
    PantallaConfiguracion()
  ];

  // Cambiar la pantalla seleccionada al hacer tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // mediaquery para que se adapte a la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomNavHeight = 70.0; 

    return Scaffold(
      body: Column(
        children: [
          
          Expanded(
            child: _screens[_selectedIndex], // Mostrar la pantalla seleccionada
          ),
        ],
      ),
      // Barra de navegación inferior
      bottomNavigationBar: Container(
        color: Colors.blue[50], 
        height: bottomNavHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1, 
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, 
            children: [
              // Opción: Búsqueda
              GestureDetector(
                onTap: () {
                  _onItemTapped(0); 
                },
                child: SizedBox(
                  width: screenWidth * 0.25, 
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.search, size: 30, color: Colors.blue), 
                      Text("Búsqueda", style: TextStyle(color: Colors.blue)), 
                    ],
                  ),
                ),
              ),
              // Opción: Vuelos Guardados
              GestureDetector(
                onTap: () {
                  _onItemTapped(1); 
                },
                child: SizedBox(
                  width: screenWidth * 0.25, 
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.bookmark, size: 30, color: Colors.blue),
                      Text("Guardados", style: TextStyle(color: Colors.blue)), 
                    ],
                  ),
                ),
              ),
              // Opción: Configuración
              GestureDetector(
                onTap: () {
                  _onItemTapped(2); 
                },
                child: SizedBox(
                  width: screenWidth * 0.25, 
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.settings, size: 30, color: Colors.blue), 
                      Text("Configuración", style: TextStyle(color: Colors.blue)), 
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

