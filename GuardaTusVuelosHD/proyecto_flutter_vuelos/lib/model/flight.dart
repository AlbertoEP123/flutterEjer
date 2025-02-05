class Flight {
  final int? id;
  final String? aeropuertoOrigen;
  final String? aeropuertoDestino;
  final String? horaSalida;
  final String? horaLlegada;
  final int? precio;
  final String? aerolinea;
  final String? moneda;

  const Flight({
    this.id,
    this.aeropuertoOrigen,
    this.aeropuertoDestino,
    this.horaSalida,
    this.horaLlegada,
    this.precio,
    this.aerolinea,
    this.moneda
  });

  // Convertir un Flight a un Map para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aeropuertoOrigen': aeropuertoOrigen,
      'aeropuertoDestino': aeropuertoDestino,
      'horaSalida': horaSalida,
      'horaLlegada': horaLlegada,
      'precio': precio,
      'aerolinea': aerolinea,
      'moneda' : moneda
    };
  }

  // Convertir un JSON a un Flight
  factory Flight.fromJson(Map<String, dynamic> json, String moneda) {
    return Flight(
      aeropuertoOrigen: json['flights'][0]['departure_airport']['name'],
      aeropuertoDestino: json['flights'][0]['arrival_airport']['name'],
      horaSalida: json['flights'][0]['departure_airport']['time'],
      horaLlegada: json['flights'][0]['arrival_airport']['time'],
      precio: json['price'],
      aerolinea: json['flights'][0]['airline'],
      moneda:moneda
    );
  }

  // Convertir un Map de la base de datos a un Flight
  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      id: map['id'],
      aeropuertoOrigen: map['aeropuertoOrigen'],
      aeropuertoDestino: map['aeropuertoDestino'],
      horaSalida: map['horaSalida'],
      horaLlegada: map['horaLlegada'],
      precio: map['precio'],
      aerolinea: map['aerolinea'],
      moneda: map['moneda']
    );
  }

 
}