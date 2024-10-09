import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '/MenuLateral.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Drawer',
        
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Drawer"),
          ),
          
          drawer: const MenuLateral(),
          body: Center(
            child: Text("Alberto Enrique Pulido \nhttps://github.com/AlbertoEP123/flutterEjer",
            style: GoogleFonts.abel(color: const Color.fromARGB(255, 114, 7, 255), fontSize: 35)),
            
           
      ),
        ));
  }
}



  

