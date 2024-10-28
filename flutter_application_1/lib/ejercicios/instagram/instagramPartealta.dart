import 'package:flutter/material.dart';

class Instagrampartealta extends StatelessWidget {
  const Instagrampartealta({super.key});


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(),
      
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
           const Expanded(child: Column(
                crossAxisAlignment:
                        CrossAxisAlignment.start, 
           ),
           ),
        ],
      ),
  
    );
  }
}
 