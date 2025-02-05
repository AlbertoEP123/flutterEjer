import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantalla_busqueda.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantalla_configuracion.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantalla_vuelos_guardados.dart';

class Drawerinicio extends StatefulWidget {
  const Drawerinicio({super.key});

  @override
  DrawerinicioState createState() => DrawerinicioState();
}

class DrawerinicioState extends State<Drawerinicio> {
  int _selectedIndex = 0;
  
  final GlobalKey<PantallabusquedaState> _busquedaKey = GlobalKey<PantallabusquedaState>();

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _initializeScreens();
  }
  // Inicializa las pantallas, ademas de mantener los vuelos guardados
  void _initializeScreens() {
    _screens = <Widget>[
      Pantallabusqueda(key: _busquedaKey),
      Pantallavuelosguardados(onFavoritesChanged: _updateFavorites),
      const PantallaConfiguracion(),
    ];
  }

// Actualiza los favoritos de la pantalla de búsqueda
  void _updateFavorites() {
    if (_busquedaKey.currentState != null) {
      _busquedaKey.currentState!.updateFavoriteStatus();
    }
  }

  // Método para cambiar de pantalla
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomNavHeight = 70.0;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
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
              _buildNavItem(0, Icons.search, "Búsqueda"),
              _buildNavItem(1, Icons.bookmark, "Guardados"),
              _buildNavItem(2, Icons.settings, "Configuración"),
            ],
          ),
        ),
      ),
    );
  }

// Método para construir un item de la barra de navegación

  Widget _buildNavItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            Text(label, style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}