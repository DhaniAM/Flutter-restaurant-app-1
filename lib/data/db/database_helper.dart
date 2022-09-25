import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableBookmark = "bookmarks";

  Future<Database> _initDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      "$path/restaurantapp.db",
      onCreate: (db, version) async {
        await db.execute(''' CREATE TABLE $_tableBookmark(
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating INT
          )
        ''');
      },
      version: 1,
    );
    return db;
  }

  /// Getter
  Future<Database?> get database async {
    /// if _database null =>  _initDb => return _database
    /// else return _database
    return _database ??= await _initDb();
  }

  /// inserting
  Future insertBookmark(Restaurants restaurants) async {
    final db = await database;
    await db!.insert(_tableBookmark, restaurants.toJson());
  }

  /// get all bookmark data
  Future<List<Restaurants>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableBookmark);
    return results.map((val) => Restaurants.fromJson(val)).toList();
  }

  /// find bookmark with Id
  Future<Map> getBookmarkById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tableBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  /// delete bookmark
  Future removeBookmark(String id) async {
    final db = await database;

    await db!.delete(
      _tableBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
