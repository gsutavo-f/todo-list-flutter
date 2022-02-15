import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  Color backgroundColor = Color(0xff1b1b1b);
  Color usefulColor = Color(0xff292929);
  Color textColor = Color(0xff808080);
  Color primaryColor = Color(0xff0090ff);
  Color secondaryColor = Color(0xffffa500);

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: const [
                      Text(
                        'Todo List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gotham',
                        ),
                      ),
                      // SizedBox(width: 4.0),
                      // Container(
                      //   child: Text(
                      //     'List',
                      //     style: TextStyle(
                      //       color: backgroundColor,
                      //       fontSize: 36.0,
                      //       fontWeight: FontWeight.w900,
                      //     ),
                      //   ),
                      //   padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(3.0),
                      //     color: primaryColor,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          fillColor: usefulColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textColor),
                          ),
                          hintText: 'Adicione uma tarefa',
                          hintStyle: TextStyle(
                            color: textColor,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
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
                        primary: primaryColor,
                        padding: EdgeInsets.all(14.0),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        color: usefulColor,
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
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: showDeleteConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          padding: EdgeInsets.all(14.0)),
                      child: Text(
                        'Limpar tudo',
                        style: TextStyle(
                          color: usefulColor,
                        ),
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
    deletedTodo = todo;
    deletedPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso!',
          style: TextStyle(
            color: textColor,
          ),
        ),
        backgroundColor: usefulColor,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: primaryColor,
          onPressed: () {
            setState(() {
              todos.insert(deletedPos!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: usefulColor,
        title: Text(
          'Limpar tudo?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: Text(
          'Você tem certeza que deseja apagar todas as tarefas',
          style: TextStyle(
            color: textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(primary: Colors.white),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            style: TextButton.styleFrom(primary: primaryColor),
            child: Text('Limpar tudo'),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
