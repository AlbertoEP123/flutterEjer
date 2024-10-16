import 'package:flutter/material.dart';
import 'package:flutter_application_1/ejercicios/menulateral.dart';
import 'package:google_fonts/google_fonts.dart';



void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});


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



  

