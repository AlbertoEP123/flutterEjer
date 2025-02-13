import 'package:proyecto_flutter_vuelos/model/configuracion.dart';
import 'package:sqflite/sqflite.dart';

class BdConfiguracion {
  static Database? _database;

  // Inicializa la base de datos
  static Future<Database> initDatabase() async {
    try {
      if (_database == null) {
        var databasePath = await getDatabasesPath();
        String path = '$databasePath/configuracion.db';

        // Abrir la base de datos
        _database = await openDatabase(
          path,
          version: 1,
          onCreate: (Database db, int version) async {
            // Crear la tabla si no existe
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
            // Si no existe, la crea
            if (tables.isEmpty) {
              await db.execute('''
                CREATE TABLE configuracion(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  moneda TEXT NOT NULL,
                  idioma TEXT NOT NULL
                )
              ''');
            }
          },
        );

        // Verificar si ya hay datos en la tabla
        final count = Sqflite.firstIntValue(
            await _database!.rawQuery('SELECT COUNT(*) FROM configuracion'));

        if (count == 0) {
          // Insertar valores por defecto si la tabla está vacía
          await _database!.insert('configuracion', {
            'moneda': 'EUR',
            'idioma': 'ESP',
          });
        }
      }

      // Cargar las preferencias por defecto
      await loadPreferences();
    } catch (e) {
      //print('Error al inicializar la base de datos: ${e.toString()}');
      rethrow; // Lanza el error para poder capturarlo fuera de la función si es necesario
    }

    return _database!;
  }

  // Función para guardar las preferencias de moneda y idioma
  Future<void> savePreferences(String moneda, String idioma) async {
    try {
      if (_database == null) return;

      // Eliminar las configuraciones anteriores
      await _database!.delete('configuracion');

      // Insertar las nuevas configuraciones
      await _database!.insert('configuracion', {
        'moneda': moneda,
        'idioma': idioma,
      });

      // Actualizar las preferencias globales
      Configuracion.moneda = moneda;
      Configuracion.idioma = idioma;
    } catch (e) {
      //print('Error al guardar preferencias: ${e.toString()}');
    }
  }

  // Método para cargar las preferencias desde la base de datos
  static Future<void> loadPreferences() async {
    try {
      if (_database == null) return;

      // Consultar la tabla de configuración
      final List<Map<String, dynamic>> results =
          await _database!.query('configuracion');
      
      if (results.isNotEmpty) {
        // Cargar las preferencias en la clase Configuracion
        Configuracion.moneda = results.first['moneda'] as String;
        Configuracion.idioma = results.first['idioma'] as String;
      }
    } catch (e) {
      //print('Error al cargar preferencias: ${e.toString()}');
    }
  }
}

class Sqflite {
  static int? firstIntValue(List<Map<String, Object?>> list) {
    if (list.isEmpty) return null;
    return list.first.values.first as int;
  }
}
