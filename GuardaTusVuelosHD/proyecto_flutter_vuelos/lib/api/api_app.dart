import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_flutter_vuelos/model/flight.dart';

class ApiApp {

// Metodo para obtener los vuelos
static Future<List<Flight>> fetchFlights(
      String ciudadOrigen, String ciudadDestino, DateTime fechaSalida, DateTime fechaVuelta, int tipo, int nPasajeros) async {
  String url ;
  // Si el tipo es 1, es un vuelo de ida y vuelta
    if(tipo==1){
      url = "https://serpapi.com/search.json?engine=google_flights&departure_id=$ciudadOrigen&arrival_id=$ciudadDestino&outbound_date=${fechaSalida.toString().substring(0,10)}&return_date=${fechaVuelta.toString().substring(0,10)}&type=$tipo&currency=EUR&hl=en&adults=$nPasajeros&api_key=132a005a4547169592f9c61e7006cf60a772f8cb5a69b2920d12ddefe6b07054";
    }else{
      url = "https://serpapi.com/search.json?engine=google_flights&departure_id=$ciudadOrigen&arrival_id=$ciudadDestino&outbound_date=${fechaSalida.toString().substring(0,10)}&type=$tipo&hl=en&currency=EUR&adults=$nPasajeros&api_key=132a005a4547169592f9c61e7006cf60a772f8cb5a69b2920d12ddefe6b07054";
    }

    // Realiza la petición HTTP
    try {
      final response = await http.get(Uri.parse(url));
      
      // Comprueba si la petición ha sido correcta
      if (response.statusCode == 200) {
        
        // Parsear el JSON
        var data = json.decode(response.body)['other_flights']as List;

        // Mapear los vuelos
        List<Flight> vuelos =
            data.map((json) => Flight.fromJson(json)).toList();

        // Filtrar vuelos según las fechas
        return vuelos.where((flight) {
          // Parsear la hora de salida y llegada
          DateTime? horaSalida = DateTime.tryParse(flight.horaSalida ?? '');
          DateTime? horaLlegada = DateTime.tryParse(flight.horaLlegada ?? '');
        
          if (horaSalida == null || horaLlegada == null) {
            // Si no se puede parsear la hora de salida, lo descarto
            return false;
          }
              // if (fechaSalida.year != horaSalida.year ||
              //   fechaSalida.month != horaSalida.month ||
              //   fechaSalida.day != horaSalida.day) {
              // return false; // Si el año, mes o día no coinciden con la fecha de salida seleccionada, lo excluimos
              // }
     
          return true; // Si pasa todas las comprobaciones, lo incluimos
          
        }).toList();
      } else {
        throw Exception(
            'Error al obtener los vuelos. Código: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener los vuelos');
    }
  }
 
}