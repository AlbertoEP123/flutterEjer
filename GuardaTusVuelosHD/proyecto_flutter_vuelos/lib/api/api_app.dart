import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_flutter_vuelos/model/flight.dart';

class ApiApp {

static Future<List<Flight>> fetchFlights(
      String ciudadOrigen, String ciudadDestino, DateTime fechaSalida, DateTime fechaVuelta) async {
    //String url =
      //  "https://api.aviationstack.com/v1/flights?access_key=f2a5651bb06942d6d5c5de3826f27b18&dep_iata=$ciudadOrigen&arr_iata=$ciudadDestino";
  String url = "https://serpapi.com/search.json?engine=google_flights&departure_id=$ciudadOrigen&arrival_id=$ciudadDestino&outbound_date=${fechaSalida.toString().substring(0,10)}&return_date=${fechaVuelta.toString().substring(0,10)}&hl=en&api_key=132a005a4547169592f9c61e7006cf60a772f8cb5a69b2920d12ddefe6b07054";
    
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['other_flights']as List;

        List<Flight> vuelos =
            data.map((json) => Flight.fromJson(json)).toList();

        // Filtrar vuelos según las fechas
        return vuelos.where((flight) {
          DateTime? horaSalida = DateTime.tryParse(flight.horaSalida ?? '');
          DateTime? horaLlegada = DateTime.tryParse(flight.horaLlegada ?? '');
          print(horaSalida);
          print(horaLlegada);
          if (horaSalida == null || horaLlegada == null) {
            // Si no se puede parsear la hora de salida, lo descartamos
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