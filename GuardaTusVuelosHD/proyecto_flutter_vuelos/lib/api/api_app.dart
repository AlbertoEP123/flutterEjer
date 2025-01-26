import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiAPP {
  final String apiKey = '';  
  final String baseUrl = 'https://partners.api.skyscanner.net/apiservices';

  // Función para buscar vuelos
  Future<List<Map<String, dynamic>>> buscarVuelos({
    required String origen,
    required String destino,
    required DateTime salida,
    DateTime? vuelta,
    required int numeroPersonas,
  }) async {
    // Formateo fechas
    String formatoFechaIda = "${salida.year}-${salida.month.toString().padLeft(2, '0')}-${salida.day.toString().padLeft(2, '0')}";
    String formatoFechaVuelta = vuelta != null 
        ? "${vuelta.year}-${vuelta.month.toString().padLeft(2, '0')}-${vuelta.day.toString().padLeft(2, '0')}"
        : '';

    // Crear la URL de la API para la búsqueda de vuelos
    final String url = '$baseUrl/browsequotes/v1.0/US/USD/en-US/$origen/$destino/$formatoFechaIda?apiKey=$apiKey';

    // Si hay una fecha de vuelta, agregarla a la URL
    final String urlConVuelta = vuelta != null
        ? '$url&returnDate=$formatoFechaVuelta'
        : url;

    // Conexion
    try {
      final response = await http.get(Uri.parse(urlConVuelta));

      if (response.statusCode == 200) {
        // Proceso de la respuesta JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // falta la logica 
        return List<Map<String, dynamic>>.from(data['Quotes'] ?? []);
      } else {
        throw Exception('Error al obtener los datos de la API');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
