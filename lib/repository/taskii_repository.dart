import 'package:taskii/model/db_helper.dart';
import 'package:taskii/model/todo.dart';
import 'package:taskii/widgets/todo_item.dart';


class TaskiiRepository {
  static const String _table = 'taski';
  
  static Future<int> insert(Todo todo) async {
    var db = await DbHelper.getConnection();
    return db.insert('taski', todo.toMap());
  }

  static Future<List<Todo>> findAll() async {
    var db = await DbHelper.getConnection();
    var result = await db.query('taski');
    return result
        .map(
          (item) => Todo.fromMap(item),
        )
        .toList();
  }

  static Future<int> delete(int id) async {
    final db = await DbHelper.getConnection();
    return await db.delete(
      'taski',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
