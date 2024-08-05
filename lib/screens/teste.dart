import 'package:flutter/material.dart';
import 'package:taskii/constrants/colors.dart';
import 'package:taskii/model/todo.dart';
import 'package:taskii/repository/taskii_repository.dart';
import 'package:taskii/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: buildScreen(),
    );
  }

  Widget buildScreen() {
    var listOfTaski = [];
    return FutureBuilder(
      future: TaskiiRepository.findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Stack(
            children: [
              const Center(
                child: Text('Não existem taskis cadastrados'),
              ),
              TextButton(
                onPressed: () async {
                  listOfTaski = await TaskiiRepository.findAll();
                  print(listOfTaski);
                  setState(() {});
                },
                child: const Text("Atualizar"),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.0),
                          ],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: 'Adicione uma Taskii',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira uma task';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                      ),
                      child: ElevatedButton(
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            save();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tdBlue,
                          minimumSize: Size(60, 60),
                          elevation: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        listOfTaski = snapshot.data!;
        return Stack(
          children: [
            ListView.builder(
                reverse: false,
                itemCount: listOfTaski.length,
                itemBuilder: (context, index) => ToDoItem(
                      todo: listOfTaski[index],
                    ))
          ],
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          )
        ],
      ),
    );
  }

  void save() async {
    try {
      final taski = Todo(
        title: _titleController.text,
      );
      final id = await TaskiiRepository.insert(taski);
      SnackBar snackBar;
      if (id != 0) {
        snackBar = SnackBar(content: Text('A Taski foi salva com sucesso!!!'));
      } else {
        snackBar = const SnackBar(
          content:
              Text('Lamento, houve um problema ao tentar salvar a taski!!!'),
        );
      }
      // Exibir a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      print(error);
      SnackBar snackBar = const SnackBar(
        content: Text('Ops. Tivemos um problema técnico!!!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
