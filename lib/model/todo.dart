class Todo {
  int? id;
  String? title;
  bool isDone;

  Todo({
    this.id,
    required this.title,
    this.isDone = false,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'title': title,
      };

  factory Todo.fromMap(Map<String, Object?> map) => Todo(
        id: map['id'] as int,
        title: map['title'] as String,
      );
}
