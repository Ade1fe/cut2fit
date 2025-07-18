import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart'; // For generating UUIDs for IDs

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  static const _uuid = Uuid();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, 'measurements_app.db');
    print('Attempting to open database at: $databasePath');

    try {
      return await openDatabase(
        databasePath,
        version: 1,
        onCreate: _onCreate,
        onOpen: (db) async {
          print('Database opened successfully.');
          await db.execute('PRAGMA foreign_keys = ON'); // ✅ Enable foreign keys
        },
      );
    } catch (e) {
      print('Error opening database: $e');
      rethrow;
    }
  }

  Future _onCreate(Database db, int version) async {
    print('Creating database tables...');
    await db.execute('''
      CREATE TABLE clients (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        profile_picture_path TEXT, -- New column for profile picture path
        created_at TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE measurements (
        id TEXT PRIMARY KEY,
        client_id TEXT NOT NULL,
        type TEXT NOT NULL,
        value REAL NOT NULL,
        unit TEXT NOT NULL,
        measured_at TEXT NOT NULL,
        FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE
      )
    ''');
    print('Tables created successfully.');
  }

  // Client Operations
  Future<Map<String, dynamic>> insertClient(
    String name, {
    String? profilePicturePath,
  }) async {
    final db = await instance.database;
    final id = _uuid.v4();
    final client = {
      'id': id,
      'name': name,
      'profile_picture_path': profilePicturePath, // Store the path
      'created_at': DateTime.now().toIso8601String(),
    };
    print('Attempting to insert client: $client');
    try {
      await db.insert(
        'clients',
        client,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Client inserted successfully.');
      return client;
    } catch (e) {
      print('Error inserting client: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getClients() async {
    final db = await instance.database;
    return await db.query('clients', orderBy: 'created_at DESC');
  }

  Future<void> deleteClient(String clientId) async {
    final db = await instance.database;
    print('Attempting to delete client with ID: $clientId');
    try {
      // Due to FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE,
      // associated measurements will be deleted automatically.
      final rowsAffected = await db.delete(
        'clients',
        where: 'id = ?',
        whereArgs: [clientId],
      );
      print('Client deleted. Rows affected: $rowsAffected');
    } catch (e) {
      print('Error deleting client: $e');
      rethrow;
    }
  }

  // Measurement Operations
  Future<void> insertMeasurement(Map<String, dynamic> measurement) async {
    final db = await instance.database;
    final id = _uuid.v4();
    final newMeasurement = {
      'id': id,
      'client_id': measurement['client_id'],
      'type': measurement['type'],
      'value': measurement['value'],
      'unit': measurement['unit'],
      'measured_at': DateTime.now().toIso8601String(),
    };
    try {
      await db.insert(
        'measurements',
        newMeasurement,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting measurement: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getMeasurementsForClient(
    String clientId,
  ) async {
    final db = await instance.database;
    return await db.query(
      'measurements',
      where: 'client_id = ?',
      whereArgs: [clientId],
      orderBy: 'measured_at DESC',
    );
  }

  Future<void> deleteMeasurementsForClient(String clientId) async {
    final db = await instance.database;
    await db.delete(
      'measurements',
      where: 'client_id = ?',
      whereArgs: [clientId],
    );
  }
}
