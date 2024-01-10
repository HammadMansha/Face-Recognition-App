import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE images(
        id INTEGER PRIMARY KEY,
        image_path TEXT
      )
    ''');
  }

  Future<int> insertImage(String imagePath) async {
    Database db = await database;
    return await db.insert('images', {'image_path': imagePath});
  }

  Future<List<Map<String, dynamic>>> getAllImages() async {
    Database db = await database;
    return await db.query('images');
  }
}
