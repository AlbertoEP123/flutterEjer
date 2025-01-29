import 'package:flutter/material.dart';

class PantallaConfiguracion extends StatefulWidget {
  const PantallaConfiguracion({super.key});

  @override
  PantallaConfiguracionState createState() => PantallaConfiguracionState();
}

class PantallaConfiguracionState extends State<PantallaConfiguracion> {
  String moneda = 'USD';
  String idioma = 'Español';
  bool notificaciones = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[50]!, Colors.white],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/logo.png',  
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.fitHeight 
                  ),
                  const SizedBox(height: 60),

                  // Configuración de moneda
                  DropdownButton<String>(
                    value: moneda,
                    onChanged: (String? newValue) {
                      setState(() {
                        moneda = newValue!;
                      });
                    },
                    items: ['USD', 'EUR', 'MXN', 'GBP']
                        .map<DropdownMenuItem<String>>((String valor) {
                      return DropdownMenuItem<String>(
                        value: valor,
                        child: Text('Moneda: $valor')
                        ,
                      );
                    }).toList(),
                    isExpanded: true,
                  ),

                  const SizedBox(height: 20),

                  // Configuración de idioma
                  DropdownButton<String>(
                    value: idioma,
                    onChanged: (String? newValue) {
                      setState(() {
                        idioma = newValue!;
                      });
                    },
                    items: ['Español', 'Inglés', 'Francés', 'Alemán']
                        .map<DropdownMenuItem<String>>((String valor) {
                      return DropdownMenuItem<String>(
                        value: valor,
                        child: Text('Idioma: $valor'),
                      );
                    }).toList(),
                    isExpanded: true,
                  ),

                  const SizedBox(height: 20),

                  // Configuración de notificaciones
                  SwitchListTile(
                    title: const Text('Habilitar notificaciones'),
                    value: notificaciones,
                    onChanged: (bool valor) {
                      setState(() {
                        notificaciones = valor;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
