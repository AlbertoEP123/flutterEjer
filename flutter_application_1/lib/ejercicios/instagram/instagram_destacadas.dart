import 'package:flutter/material.dart';



class InstagramDestacadas extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {"imagen": "assets/avatar1.png", "text": "Nuevo", "width": 40.0, "height": 40.0},
    {"imagen": "assets/avatar2.png", "text": "Pilotando", "width": 40.0, "height": 40.0},
    {"imagen": "assets/avatar3.png", "text": "Praga", "width": 40.0, "height": 40.0},
    {"imagen": "assets/avatar4.png", "text": "Arquitectura", "width": 44.0, "height": 40.0},
    {"imagen": "assets/avatar5.png", "text": "Retratos", "width": 40.0, "height": 40.0},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(5, (index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 60,  
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      width: 75,
                      height: 75,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        width: 70,
                        height: 70,
                        alignment: Alignment.center,
                        child: Image.asset(
                          item['imagen'],  
                          width: item['width'],  // Ancho de la imagen
                          height: item['height'], // Alto de la imagen
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(item['text']), 
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
