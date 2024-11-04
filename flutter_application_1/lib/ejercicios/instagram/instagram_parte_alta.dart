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
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(25, 25, 25, 25),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: [
                  Text("alvarezdelvayo "),
                  CircleAvatar(radius: 40),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  
                  children: [
                    SizedBox(width: 65),
                    Text("1022 \nPublicaciones",),
                    SizedBox(width: 25),
                    Text("859 \nSeguidores"),
                    SizedBox(width: 25),
                    Text("211 \nSeguidos"),
                  ],
                ),
              ],
            
            ),
           
            
          ),
           const Padding(
              padding: EdgeInsets.only(left: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(3)),
                  
                ],
              ),
            ),
        ],
      ),
    );
  }
}
