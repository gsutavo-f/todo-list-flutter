import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo, required this.onDelete})
      : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (value) {
                onDelete(todo);
              },
              backgroundColor: Color(0xfffe4a49),
              foregroundColor: Colors.white,
              icon: Icons.delete_outline_rounded,
              label: 'Deletar',
            ),
          ],
          extentRatio: 0.23,
        ),
        child: todoTile(),
      ),
    );
  }

  Widget todoTile() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Color(0xff292929),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            DateFormat('dd/MM/yyyy - HH:mm').format(todo.date),
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xff808080),
            ),
          ),
          Text(
            todo.title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
