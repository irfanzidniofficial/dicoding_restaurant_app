import 'package:dicoding_restaurant_app/data/models/restaurants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _saved = 'saved';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/savedrestaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_saved (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating double
          )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertSaved(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_saved, restaurant.toMap());
  }

  Future<List<Restaurant>> getSaved() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_saved);

    return results.map((res) => Restaurant.fromMap(res)).toList();
  }

  Future<void> removeSaved(String id) async {
    final db = await database;

    await db!.delete(
      _saved,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map> getSavedbyId(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _saved,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }
}
