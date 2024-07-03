class ToDo {

  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    
    required this.id,
    required this.todoText,
    this.isDone = false,

  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todoText: 'Buy groceries',
        isDone: false
      ),
      ToDo(
        id: '02',
        todoText: 'Go shopping',
        isDone: false
      ),
      ToDo(
        id: '03',
        todoText: 'Go to gym',
        isDone: false
      ),
      ToDo(
        id: '04',
        todoText: 'Play football',
        isDone: false
      ),
      ToDo(
        id: '05',
        todoText: 'Play basketball',
        isDone: false
      ),
      ToDo(
        id: '06',
        todoText: 'Play soccer',
        isDone: true
      ),
      ToDo(
        id: '07',
        todoText: 'Play volleyball',
        isDone: true
      ),
    ];
  }
}
