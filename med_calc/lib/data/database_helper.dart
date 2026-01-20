import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _db;

  Future<void> open() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'statistics.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        return await db.execute('CREATE TABLE history (id INTEGER PRIMARY KEY, creatinine REAL, bilirubin REAL, inr REAL, sodium REAL, dialysis INT, createdAt TEXT) STRICT');
      }
    );
  }

  void addToHistory({double? creatinine, double? bilirubin, double? inr, double? sodium, bool dialysisLastWeek = false}) async {
    await _db!.transaction((txn) async {
      print(await txn.rawInsert("INSERT INTO history (creatinine, bilirubin, inr, sodium, dialysis, createdAt) VALUES (?, ?, ?, ?, ?, ?);",
      [creatinine, bilirubin, inr, sodium, dialysisLastWeek ? 1 : 0, DateTime.now().toString()]
      ));
    });
  }

  Future<List<Map<String, dynamic>>> getFullHistory() async {
    try {
      final result = await _db!.rawQuery('SELECT * FROM history ORDER BY id DESC');
      print('Reading from db: ${result.length}');
      if (result.isNotEmpty) {
        print('First calculation: ${result[0]}');
      }
      return result;
    } catch (e) {
        print('Database error while reading: $e');
        rethrow;
    }
  }

  void close() async {
    _db!.close();
  }
}