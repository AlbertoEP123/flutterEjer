import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/instagram/instagram_destacadas.dart';
import 'package:flutter_application_1/ejercicios/drawer.dart'; 

class Instagrampartealta extends StatelessWidget {
  const Instagrampartealta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instagram"), 
      ),
      drawer: const MenuLateral(),  

      body: Column(
        children: [
          // Container nombre usuario
          Container(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            color: const Color.fromARGB(255, 255, 255, 255),
            child: const Row(
              children: [
                Text(
                  "alvarezdelvayo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Container avatar, publicaciones y biografía 
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                // avatar
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('avatar.webp'), 
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '1026\nPublicaciones',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 1),
                              Text(
                                '859\nSeguidores',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 1),
                              Text(
                                '211\nSeguidos',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Editar perfil
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 148, 148, 148),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 345,
                                    height: 28,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Editar perfil',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // biografía 
                const Text(
                  "Fernando Álvarez del Vayo\n\nNunca sabes lo que te depara el futuro",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ), // Container clase destacadas
          Expanded(child: InstagramDestacadas()),  // Aquí va el widget de InstagramDestacadas
        ],
      ),
    );
  }
}
