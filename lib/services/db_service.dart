import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _database;

  // Get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    // If the database does not exist, we create it
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'workouts.db'); // Path to the database file

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create the 'workouts' table if it doesn't exist
        db.execute('''
          CREATE TABLE workouts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            workout_name TEXT,
            reps INTEGER,
            weight REAL
          )
        ''');

        // Create the 'users' table for registration (optional)
        db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT
          )
        ''');
      },
    );
  }

  // Insert a workout into the database
  Future<void> insertWorkout(Map<String, dynamic> workout) async {
    final db = await database;
    await db.insert(
      'workouts',
      workout,
      conflictAlgorithm: ConflictAlgorithm.replace, // In case of conflict
    );
  }

  // Get all workouts from the database
  Future<List<Map<String, dynamic>>> getWorkouts() async {
    final db = await database;
    return await db.query('workouts');
  }

  // Validate user (this method is optional, can be used for login functionality)
  Future<bool> validateUser(String username, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty;
  }

  // Insert a new user into the database (for registration)
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace, // In case of conflict
    );
  }
}
