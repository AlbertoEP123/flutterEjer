import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/instagram/instagram_destacadas.dart';
import 'package:flutter_application_1/screens/drawer.dart'; 

class Instagrampartealta extends StatelessWidget {
  const Instagrampartealta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Obtengo el tamaño de la pantalla, para evitar el overflow
    final anchura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Instagram"), 
      ),
      drawer: const MenuLateral(),  

      body: Column(
        children: [
          // Container perfil
          Container(
            padding: EdgeInsets.only(
              top: altura * 0.02,  
              left: anchura * 0.05,  
            ),
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

          // Container del avatar y demas
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: anchura * 0.03,  // Ajuste de padding horizontal
              vertical: altura * 0.02,  // y vertical
            ),
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/avatar.webp'),
                    ),
                    SizedBox(width: anchura * 0.05),  
                    Flexible( 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(  // Esto también hace que los textos no se desborden
                                child: Text(
                                  '1026\nPublicaciones',
                                  style: TextStyle(fontSize: anchura * 0.03),
                                  overflow: TextOverflow.ellipsis, 
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '859\nSeguidores',
                                  style: TextStyle(fontSize: anchura * 0.03),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '211\nSeguidos',
                                  style: TextStyle(fontSize: anchura * 0.03),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: altura * 0.02),
                          Padding(
                            padding: EdgeInsets.only(left: anchura * 0.02),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: anchura * 0.05,
                                vertical: altura * 0.01,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 148, 148, 148),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
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
                SizedBox(height: altura * 0.02), 
                // Biografía
                const Text(
                  "Fernando Álvarez del Vayo\n\nNunca sabes lo que te depara el futuro",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),

         
          Expanded(
            child: InstagramDestacadas(),  
          ),
        ],
      ),
    );
  }
}
