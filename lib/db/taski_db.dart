import 'package:sqflite/sqflite.dart';
import 'package:taskii/db/db_service.dart';
import 'package:taskii/model/todo.dart';

class TaskiDB {
  final tableName = 'taski';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    );""");
  }

  Future<int> create(Database database, {required String title}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (todoText) VALUES (?)''',
      [title],
    );
  }

  Future<List<Todo>> fetchAll() async {
    final database = await DatabaseService().database;
    final todos = await database.rawQuery(''' SELECT * FROM $tableName''');
    return todos.map((todo) => Todo.fromSqfliteDatabase(todo)).toList();
  }

  Future<Todo> fetchById(int id) async {
    final database = await DatabaseService().database;
    final todo = await database
        .rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id]);
    return Todo.fromSqfliteDatabase(todo.first);
  }

  Future<int> update({required int id, String? title}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        if (title != null) 'title': title,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }
  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.execute('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }
}
