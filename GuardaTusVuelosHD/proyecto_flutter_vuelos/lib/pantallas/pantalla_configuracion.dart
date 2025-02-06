import 'package:flutter/material.dart';
import 'package:proyecto_flutter_vuelos/persistencia/bd_configuracion.dart';


class PantallaConfiguracion extends StatefulWidget {
  const PantallaConfiguracion({super.key});

  @override
  PantallaConfiguracionState createState() => PantallaConfiguracionState();
}
BdConfiguracion bd = BdConfiguracion();

Future<void> _botonPref(String moneda, String idioma) async {
  
 await bd.savePreferences(moneda,idioma);
  
}

class PantallaConfiguracionState extends State<PantallaConfiguracion> {
  static String moneda = 'USD';
  static String idioma = 'Español';

  @override
  void initState() {
    super.initState();
    
  }
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
                    height: 170,
                    fit: BoxFit.fitHeight 
                  ),
                  const SizedBox(height: 60),

                  // Configuración de moneda
                  DropdownButton<String>(
                    value: moneda,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          moneda = newValue;
                        });
                      }
                    },
                    items: ['USD', 'EUR', 'MXN', 'GBP']
                        .map<DropdownMenuItem<String>>((String valor) {
                      return DropdownMenuItem<String>(
                        value: valor,
                        child: Text('Moneda: $valor'),
                      );
                    }).toList(),
                    isExpanded: true,
                  ),
                  

                  const SizedBox(height: 20),

                  // Botón para guardar la configuración
                  ElevatedButton(
                    onPressed: () => _botonPref(moneda,idioma),
          
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    ),
                    child: const Text('Guardar Configuración'),
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


