class Flight {
  final String? aeropuertoOrigen;
  final String? aeropuertoDestino;
  final String? horaSalida;
  final String? horaLlegada;

  const Flight({
    this.aeropuertoOrigen,
    this.aeropuertoDestino,
    this.horaSalida,
    this.horaLlegada,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      aeropuertoOrigen: json['flights'][0]['departure_airport']['name'],
      aeropuertoDestino: json['flights'][0]['arrival_airport']['name'],
      horaSalida: json['flights'][0]['departure_airport']['time'],
      horaLlegada: json['flights'][0]['arrival_airport']['time'],
      
    );
  }
}
