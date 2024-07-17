import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constrants/colors.dart';
import '../widgets/todo_item.dart';

class Newtask extends StatefulWidget {
  const Newtask({super.key});

  @override
  State<Newtask> createState() => _NewtaskState();
}

class _NewtaskState extends State<Newtask> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: "  Insert your message",
                    ),
                    scrollPadding: EdgeInsets.all(19.0),
                    keyboardType: TextInputType.multiline,
                    maxLines: 99999,
                    autofocus: true,
                  )
                ],
              ),
            ),
          ),
          for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.only(bottom: 5),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 280),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    _addToDoItem();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                  label: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white, // Set the desired color here
                    ),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }
  
void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }