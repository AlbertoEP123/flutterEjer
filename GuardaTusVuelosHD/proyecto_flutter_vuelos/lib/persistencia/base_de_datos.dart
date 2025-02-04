import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Usa sqflite_common_ffi
import '../model/flight.dart';

// Definir las clases para la base de datos
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('./lib/persistencia/guardaVuelosDB.db');
    
      return _database!;
  }

  Future<Database> _initDB(String path) async {
    
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

 void _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE favoritos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      aeropuertoOrigen TEXT,
      aeropuertoDestino TEXT,
      horaSalida TEXT,
      horaLlegada TEXT,
      precio INTEGER
    )
  ''');
}

  // Insertar un vuelo en la base de datos
 Future<int> insertFavorite(Map<String, dynamic> flightData) async {
    final db = await instance.database;
    return await db.insert('favoritos', flightData); // Acepta un Map<String, dynamic>
  }

  // Eliminar un vuelo por su ID
  Future<int> deleteFavorite(int id) async {
    final db = await instance.database;
    return await db.delete(
      'favoritos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future <Flight> buscarID(int id) async {
    final db = await instance.database;
    return await db.query('favoritos', where: 'id = ?', 
    whereArgs: [id]).then((value) =>  Flight.fromMap(value.first));
  }
  // Obtener todos los vuelos favoritos
  Future<List<Flight>> getFavorites() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('favoritos');
    return List.generate(maps.length, (i) {
      return Flight.fromMap(maps[i]);
    });
  }
}
