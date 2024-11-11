import 'package:flutter/material.dart';

class InstagramParteBaja extends StatelessWidget {
  const InstagramParteBaja({super.key});

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
                    
                  },
                ),
             
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),
          
          //contenido de la cuadrícula
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Número de columnas
                mainAxisSpacing: 8.0, // Espacio entre filas
                crossAxisSpacing: 8.0, // Espacio entre columnas
              ),
              itemCount: 9, // Número de imágenes 
              itemBuilder: (context, index) {
                // Ruta de las imagenes en una lista
                final List<String> imagePaths = [
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

                return Image.asset(
                  imagePaths[index], // array de imágenes
                  fit: BoxFit.cover, // Ajusto bien al tamaño
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
