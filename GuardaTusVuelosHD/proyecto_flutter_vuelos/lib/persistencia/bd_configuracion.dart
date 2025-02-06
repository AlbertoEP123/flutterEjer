import 'package:proyecto_flutter_vuelos/model/configuracion.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BdConfiguracion {
  static Database? _database;
 
  // Inicializa la base de datos
  static Future<Database> initDatabase() async {
    try {
      sqfliteFfiInit();
      if (_database == null) {
        // Asegurarse de que sqflite_ffi está inicializado
        sqfliteFfiInit();

        final path = './lib/persistencia/configuracion.db';
        _database = await openDatabase(
          path,
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''
              CREATE TABLE configuracion(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                moneda TEXT NOT NULL,
                idioma TEXT NOT NULL
              )
            ''');
          },
          onOpen: (Database db) async {
            // Verificar si la tabla existe
            final tables = await db.query(
              'sqlite_master',
              where: 'type = ? AND name = ?',
              whereArgs: ['table', 'configuracion'],
            );
            // 
            if (tables.isEmpty) {
              await db.execute('''
                CREATE TABLE IF NOT EXISTS configuracion(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  moneda TEXT NOT NULL,
                  idioma TEXT NOT NULL
                )
              ''');
            }
          },
        );

        // Insertar valores por defecto si la tabla está vacía
        final count = Sqflite.firstIntValue(
            await _database!.rawQuery('SELECT COUNT(*) FROM configuracion'));

        if (count == 0) {
          await _database!.insert('configuracion', {
            'moneda': 'EUR',
            'idioma': 'ESP',
          });
        }
      }

      await loadPreferences();
    } catch (e) {
      e.toString();
    }
    return _database!;
  }

  Future<void> savePreferences(String moneda, String idioma) async {
    try {
      if (_database == null) return;

      await _database!.delete('configuracion');
      await _database!.insert('configuracion', {
        'moneda': moneda,
        'idioma': idioma,
      });
      Configuracion.moneda = moneda;
      Configuracion.idioma = idioma;

    } catch (e) {
      e.toString();
    }
  }

  static Future<void> loadPreferences() async {
    try {
      if (_database == null) return;

      final List<Map<String, dynamic>> results =
          await _database!.query('configuracion');
      if (results.isNotEmpty) {
        Configuracion.moneda = results.first['moneda'] as String;
        Configuracion.idioma = results.first['idioma'] as String;
      }
    } catch (e) {
      e.toString();
    }
  }
}

class Sqflite {
  static int? firstIntValue(List<Map<String, Object?>> list) {
    if (list.isEmpty) return null;
    return list.first.values.first as int;
  }
}
