import 'package:flutter/material.dart';


class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Actividad Flutter 1", style: TextStyle(color: Colors.black)),
            accountEmail: Text("aenrpul472@g.educaand.es", style: TextStyle(color: Colors.black)),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: const Text("1. Inicio"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/');
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
                Navigator.of(context).pushNamed('/ejercicio2');
              },
            ),
          ),
          ListTile(
            title: const Text("3. Fotos en columna"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/ejercicio3');
            },
          ),
          ListTile(
            title: const Text("4. Iconos"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/ejercicio4');
            },
          ),
          ListTile(
            title: const Text("5. Ejercicio resuelto"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/ejercicio5');
            },
          ),
          ListTile(
            title: const Text("6. Ejercicio teléfonos"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/ejercicio6');
            },
          ),
          ListTile(
            title: const Text("7. Filas y columnas anidadas"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/ejercicio7');
            },
          ),
          ListTile(
            title: const Text("8. Instagram"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/instagram');
            },
          ),
          ListTile(
            title: const Text("9. Imagenes Aleatorias"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/ejercicio9');
            },
          ),
        ],
      ),
    );
  }
}