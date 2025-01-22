import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantallaBusqueda.dart';
import 'package:proyecto_flutter_vuelos/pantallas/pantallaVuelosGuardados.dart';  

class Drawerinicio extends StatelessWidget {
  const Drawerinicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("ReservaTusVuelosHD", style: TextStyle(color: Colors.black)),
            accountEmail: Text("aenrpul472@g.educaand.es", style: TextStyle(color: Colors.black)),
            decoration: BoxDecoration(
              // Uncomment and customize if you want a background image
              // image: DecorationImage(
              //   image: AssetImage("assets/image.png"),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
            ListTile(
            title: const Text("Inicio"),
            onTap: () {
              Navigator.of(context).pop(); 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Drawerinicio()),  
              );
            },
          ),
          ListTile(
            title: const Text("Busqueda de vuelos"),
            onTap: () {
              Navigator.of(context).pop(); 
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Pantallabusqueda()),  
              );
            },
          ),
          ListTile(
            title: const Text("Vuelos Guardados"),
            onTap: () {
              Navigator.of(context).pop(); 
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Pantallavuelosguardados()),  
              );
            },
          ),
          ListTile(
            title: const Text("Configuracion"),
            onTap: () {
              Navigator.of(context).pop();  
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Pantallabusqueda()),  
              );
            },
          ),
        ],
      ),
    );
  }
}
