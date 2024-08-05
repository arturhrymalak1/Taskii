import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> getConnection() async {
    const String dbName = 'taski.db';
    final String dbPath = await getDatabasesPath();
    return await openDatabase(
      '$dbPath$dbName',
      version: 1,
      onCreate: (db, _) async {
        await db.execute(
            'CREATE TABLE taski (id INTEGER PRIMARY KEY AUTOINCREMENT, description VARCHAR(255) NOT NULL);');
      },
    );
  }
}
