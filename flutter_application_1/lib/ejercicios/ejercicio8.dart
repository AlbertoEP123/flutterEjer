import 'package:flutter/material.dart';

class Ejercicio8 extends StatelessWidget {
  const Ejercicio8({super.key});


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(25, 25, 25, 25),
            child: const Row(
              children: [
                CircleAvatar(radius: 40),
               
              ],
            

              
            ),
            
          ),
           const SizedBox(width:15),
           Expanded(child: Column(
                crossAxisAlignment:
                        CrossAxisAlignment.start, 
           ),
           ),
        ],
      ),
  
    );
  }
}
 