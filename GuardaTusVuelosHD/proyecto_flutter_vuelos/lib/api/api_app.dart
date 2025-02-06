import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_flutter_vuelos/model/flight.dart';


class ApiApp {

// Metodo para obtener los vuelos
static Future<List<Flight>> fetchFlights(
      String ciudadOrigen, String ciudadDestino, DateTime fechaSalida, DateTime fechaVuelta, int tipo, int nPasajeros, String moneda) async {
  String url ;
  // Si el tipo es 1, es un vuelo de ida y vuelta
    if(tipo==1){
      url = "https://serpapi.com/search.json?engine=google_flights&departure_id=$ciudadOrigen&arrival_id=$ciudadDestino&outbound_date=${fechaSalida.toString().substring(0,10)}&return_date=${fechaVuelta.toString().substring(0,10)}&type=$tipo&currency=$moneda&hl=en&adults=$nPasajeros&api_key=22444223f4ca84ed0407a56f4ff1c3f114f084d21a77640369c4b6020000da38";
    }else{
      url = "https://serpapi.com/search.json?engine=google_flights&departure_id=$ciudadOrigen&arrival_id=$ciudadDestino&outbound_date=${fechaSalida.toString().substring(0,10)}&type=$tipo&hl=en&currency=$moneda&adults=$nPasajeros&api_key=22444223f4ca84ed0407a56f4ff1c3f114f084d21a77640369c4b6020000da38";
    }
    //print(url);
    // Realiza la petición HTTP
      final response = await http.get(Uri.parse(url));
      //print(response.body);
      //print(response.statusCode);
      // Comprueba si la petición ha sido correcta
      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        // Parsear el JSON
        List data;
        try {
          data = jsonBody['best_flights']as List;
        if(data.isEmpty){
          data = jsonBody['other_flights']as List;
        }
        } catch (e) {
          var variable = json.decode(response.body)['error'];
        throw Exception('Error al obtener los vuelos. $variable');
        }
        
        String moneda = jsonBody['search_parameters']['currency'];
        // Mapear los vuelos
        List<Flight> vuelos =
            data.map((json) => Flight.fromJson(json, moneda)).toList();

        // Filtrar vuelos según las fechas
        return vuelos.where((flight) {
          // Parsear la hora de salida y llegada
          DateTime? horaSalida = DateTime.tryParse(flight.horaSalida ?? '');
          DateTime? horaLlegada = DateTime.tryParse(flight.horaLlegada ?? '');
        
          if (horaSalida == null || horaLlegada == null) {
            // Si no se puede parsear la hora de salida, lo descarto
            return false;
          }              
          return true; // Si pasa todas las comprobaciones, lo incluimos
          
        }).toList();
      } else {
       // print(response.statusCode);
        throw Exception("Error en la petición");
      }
    
  }

  // Método para obtener los códigos de aeropuertos
 static String? obtenerCodigoA(String ciudad) {
    // Normalizar la entrada: quitar espacios en blanco y convertir a formato título
    ciudad = ciudad.trim().split(' ').map((word) => word.capitalize()).join(' ');
    
    Map<String, String> aeropuertos = {
      "Madrid": "MAD",
      "Barcelona": "BCN",
      "Valencia": "VLC",
      "Sevilla": "SVQ",
      "Bilbao": "BIO",
      "Málaga": "AGP",
      "Palma De Mallorca": "PMI",
      "Tenerife": "TFN",
      "Santiago De Compostela": "SCQ",
      "Ibiza": "IBZ",
      "Londres": "LHR",
      "París": "CDG",
      "Berlín": "BER",
      "Roma": "FCO",
      "Ámsterdam": "AMS",
      "Viena": "VIE",
      "Praga": "PRG",
      "Bruselas": "BRU",
      "Copenhague": "CPH",
      "Estocolmo": "ARN",
      "Dublín": "DUB",
      "Helsinki": "HEL",
      "Lisboa": "LIS",
      "Varsovia": "WAW",
      "Budapest": "BUD",
      "Atenas": "ATH",
      "Oslo": "OSL",
      "Zúrich": "ZRH",
      "Moscú": "SVO",
      "Estambul": "IST"
     
    };
    
    return aeropuertos[ciudad];
  }
}

// Extensión para capitalizar una cadena de texto
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}


  
  


