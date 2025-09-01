import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            name TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  // Save user
  static Future<void> saveUser(String email, String name, String password) async {
    final db = await database;
    await db.insert('users', {
      'email': email,
      'name': name,
      'password': password,
    });
  }

  // Get user by email and password
  static Future<UserModel?> getUser(String email, String password) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      final map = maps.first;
      return UserModel(
        id: map['id'].toString(),
        email: map['email'] as String,
        name: map['name'] as String,
      );
    }
    return null;
  }

  // Check if email exists
  static Future<bool> emailExists(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }
}