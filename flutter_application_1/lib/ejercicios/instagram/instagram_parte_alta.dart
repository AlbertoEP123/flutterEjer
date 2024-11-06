import 'package:flutter/material.dart';

class Instagrampartealta extends StatelessWidget {
  const Instagrampartealta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
          // Container avatar y publicaciones..
          Container(
            padding: const EdgeInsets.all(30),
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(''),
                ),
                const SizedBox(width: 16),
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
                      const SizedBox(
                        height: 8,
                      ),
                      // Container biografia
                      Container(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: const Column(
                          children: [
                            Text(
                              "Fernando Álvarez del Vayo\nNunca sabes lo que te depara el futuro",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                           
                          ],
                        ),
                      ),
                      Padding(
                        // editar perfil
                        padding: const EdgeInsets.only(left: 50),
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 240,
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
          ),
        ],
      ),
    );
  }
}
