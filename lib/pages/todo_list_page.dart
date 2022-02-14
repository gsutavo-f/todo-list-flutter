import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfff2bb13)),
                          ),
                          hintText: 'Adicione uma tarefa',
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        setState(() {
                          Todo newTodo = Todo(
                            title: text,
                            date: DateTime.now(),
                          );
                          todos.add(newTodo);
                        });
                        todoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xfff2bb13),
                        padding: EdgeInsets.all(14.0),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Flexible(
                  child: SlidableAutoCloseBehavior(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (Todo todo in todos)
                          TodoListItem(
                            todo: todo,
                            onDelete: onDelete,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefas pendentes',
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todos.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xfff2bb13),
                          padding: EdgeInsets.all(14.0)),
                      child: Text(
                        'Limpar tudo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
  }
}
