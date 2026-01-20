import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _db;

  void open() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'statistics.db');
    _db = await openDatabase(
      path,
      onCreate: (Database db, int version) async {
        return await db.execute('CREATE TABLE history (id INTEGER PRIMARY KEY, creatinine REAL, bilirubin REAL, inr REAL, sodium REAL, dialysis INT, createdAt TEXT) STRICT');
      }
    );
  }

  void addToHistory(double creatiline, double bilirubin, double inr, double sodium, bool dialysisLastWeek) async {
    await _db!.transaction((txn) async {
      await txn.rawInsert("INSERT INTO history (creatinine, bilirubin, inr, sodium, dialysis, createdAt) VALUES (?, ?, ?, ?, ?, ?);",
      [creatiline, bilirubin, inr, sodium, dialysisLastWeek ? 1 : 0, DateTime.now().toString()]
      );
    });
  }

  Future<List<Map<String, dynamic>>> getFullHistory() async {
    return await _db!.rawQuery('SELECT * FROM history ORDER BY id DESC');
  }

  void close() async {
    _db!.close();
  }
}