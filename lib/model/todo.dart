class Todo {
  int? id;
  String? description;
  bool isDone;

  Todo({
    this.id,
    required this.description,
    this.isDone = false,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'title': description,
      };

  factory Todo.fromMap(Map<String, Object?> map) => Todo(
        id: map['id'] as int,
        description: map['description'] as String,
      );
}
