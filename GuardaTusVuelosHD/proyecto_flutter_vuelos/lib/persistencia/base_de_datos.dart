import 'package:sqflite/sqflite.dart';
//import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Usa sqflite_common_ffi
import '../model/flight.dart';

// Definir las clases para la base de datos
class DatabaseHelper {
  static DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();
  static Database? _database;
  
 

  static Future<Database> get database async {
    if (_database != null) return _database!;
    var databasePath = await getDatabasesPath();
        String path = '$databasePath/guardaVuelosDB.db';
   
    _database = await _initDB(path);
    
      return _database!;
  }

  static Future<Database> _initDB(String path) async {
    
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

 static void _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE favoritos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      aeropuertoOrigen TEXT,
      aeropuertoDestino TEXT,
      horaSalida TEXT,
      horaLlegada TEXT,
      precio INTEGER,
      aerolinea TEXT,
      moneda TEXT,
      claseVuelo TEXT,
      maxDuracion INTEGER
    )
  ''');
}

  // Insertar un vuelo en la base de datos
 Future<int> insertFavorite(Map<String, dynamic> flightData) async {
    final db = await DatabaseHelper.database;
    return await db.insert('favoritos', flightData); // Acepta un Map<String, dynamic>
  }

  // Eliminar un vuelo por su ID
  Future<int> deleteFavorite(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      'favoritos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
   Future<bool> isFavorite(Flight flight) async {
    final db = await DatabaseHelper.database;
    final result = await db.query(
      'favoritos',
      where: 'aeropuertoOrigen = ? AND aeropuertoDestino = ? AND horaSalida = ? AND horaLlegada = ?',
      whereArgs: [flight.aeropuertoOrigen, flight.aeropuertoDestino, flight.horaSalida, flight.horaLlegada],
    );
    return result.isNotEmpty;
  }

  Future <Flight> buscarID(int id) async {
    final db = await DatabaseHelper.database;
    return await db.query('favoritos', where: 'id = ?', 
    whereArgs: [id]).then((value) =>  Flight.fromMap(value.first));
  }
  // Obtener todos los vuelos favoritos
  Future<List<Flight>> getFavorites() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('favoritos');
    return List.generate(maps.length, (i) {
      return Flight.fromMap(maps[i]);
    });
  }
}
