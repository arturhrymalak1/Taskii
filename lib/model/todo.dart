class Todo {
  String? id;
  String? title;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  factory Todo.fromSqfliteDatabase(Map<String, dynamic> map) => Todo(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? '',
      );
}
