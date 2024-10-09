import 'package:flutter/material.dart';
import 'package:flutter_application_1/Ejercicio4.dart';
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
            ListTile(
accountName: Text("Actividad Flutter 1", style: TextStyle(color: Colors.black),) ,
            accountEmail: Text("aenrpul472@g.educaand.es",style: TextStyle(color: Colors.black),) ,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("image.png"),
                    fit: BoxFit.cover)),
          ),
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
           
        ],
      ),
    );
  }
}
