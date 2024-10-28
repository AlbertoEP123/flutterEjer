import 'package:flutter/material.dart';

import 'package:flutter_application_1/ejercicios/ejercicio4.dart';
import 'package:flutter_application_1/ejercicios/ejercicio5.dart';
import 'package:flutter_application_1/ejercicios/ejercicio6.dart';
import 'package:flutter_application_1/ejercicios/ejercicio7.dart';
import 'package:flutter_application_1/ejercicios/instagram/instagramPartealta.dart';
import 'package:flutter_application_1/main.dart';
import 'Ejercicio2.dart';
import 'Ejercicio3.dart';


class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        
        children: <Widget>[
          const UserAccountsDrawerHeader(
            
            accountName: Text("Actividad Flutter 1", style: TextStyle(color: Colors.black),) ,
            accountEmail: Text("aenrpul472@g.educaand.es",style: TextStyle(color: Colors.black),) ,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("image.png"),
                    fit: BoxFit.cover)),
          ),
         ListTile(
            title: const Text("1. Inicio"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const MyApp()));
            },
            
          ),
          Ink(
            color: Colors.indigo,
            child: ListTile(
              title: const Text(
                "2. Fotos en fila",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Ejercicio2()));
              },
            ),
          ),
          ListTile(
            title: const Text("3. Fotos en columna"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Ejercicio3()));
            },
            
          ),
           ListTile(
            title: const Text("4. Iconos"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Ejercicio4()));
            },
           ),
           ListTile(
            title: const Text("5. Ejercicio resuelto"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Ejercicio5()));
            },
           ),
            ListTile(
            title: const Text("6. Ejercicio telefonos"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Ejercicio6()));
            },
           ),
             ListTile(
            title: const Text("7. Filas y columnas anidadas"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Ejercicio7()));
            },
           ),
            ListTile(
            title: const Text("8. Instagram"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Instagrampartealta()));
            },
           ),
           
          
           
        ],
      ),
    );
  }
}
