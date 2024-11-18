import 'package:flutter/material.dart';
import 'instagram_parte_baja.dart';  

class InstagramDestacadas extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {"imagen": "assets/add.webp", "text": "Nuevo", "width": 40.0, "height": 40.0},
    {"imagen": "assets/pilotando.webp", "text": "Pilotando", "width": 40.0, "height": 40.0},
    {"imagen": "assets/praga.webp", "text": "Praga", "width": 40.0, "height": 40.0},
    {"imagen": "assets/arquitectura.webp", "text": "Arquitectura", "width": 44.0, "height": 40.0},
    {"imagen": "assets/retratos.webp", "text": "Retratos", "width": 40.0, "height": 40.0},
  ];

  final ScrollController _scrollController = ScrollController();

  InstagramDestacadas({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: Padding(
        padding: const EdgeInsets.all(8.0), 
        child: Column(
          children: [
            // Scroll horizontal
            Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController, 
                child: Row(
                  children: List.generate(items.length, (index) { // lista de objetos, que seran las historias
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 80,  // Ancho fijo para los avatares
                        child: Column(
                          children: [
                            Container(
                              width: 70,  // Tamaño fijo del avatar
                              height: 70, 
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // forma circular
                                border: Border.all(
                                  width: 2,
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  item['imagen'],
                                  width: 60, // Ancho fijo para la imagen dentro del avatar
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item['text'],
                              style: const TextStyle(
                                fontSize: 12, 
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20), 
            const Expanded(child: InstagramParteBaja()), 
          ],
        ),
      ),
    );
  }
}
