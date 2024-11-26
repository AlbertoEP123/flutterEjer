import 'package:flutter/material.dart';

class InstagramParteBaja extends StatefulWidget {
  const InstagramParteBaja({super.key});

  @override
  _InstagramParteBajaState createState() => _InstagramParteBajaState();
}

class _InstagramParteBajaState extends State<InstagramParteBaja> {
  // Lista de imágenes para la primera cuadrícula
  final List<String> imagenes1 = [
    'assets/ciudad1.webp',
    'assets/fruta.webp',
    'assets/sandia.webp',
    'assets/zumo.webp',
    'assets/pmiento.webp',
    'assets/coco.webp',
    'assets/ig.webp',
    'assets/image.png',
    'assets/mens.webp'
  ];

  // Lista de imágenes para la segunda cuadrícula
  final List<String> imagenes2 = [
    'assets/mens.webp',
    'assets/ig.webp',
    'assets/coco.webp',
    'assets/pmiento.webp',
    'assets/sandia.webp',
    'assets/fruta.webp',
    'assets/ciudad1.webp',
    'assets/zumo.webp',
    'assets/image.png'
  ];

  // Variable booleana para alternar entre las dos cuadrículas
  bool esCuadricula1 = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Fila de los iconos
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              
                IconButton(
                  icon: const Icon(
                    Icons.grid_on,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      esCuadricula1 = true; 
                    });
                  },
                ),
                
              
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      esCuadricula1 = false; // Cambio a la 2 cuadricula
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Cuadricula
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Número de columnas
                mainAxisSpacing: 8.0, // Espacio entre filas
                crossAxisSpacing: 8.0, // Espacio entre columnas
              ),
              itemCount: 9, // Número de imágenes
              itemBuilder: (context, index) {
                // Elijo la lista de imágenes según el icono
                final listaImagenes = esCuadricula1 ? imagenes1 : imagenes2;

                return Image.asset(
                  listaImagenes[index], // Mostrar la imagen correspondiente
                  fit: BoxFit.cover, // Ajustar el tamaño
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
