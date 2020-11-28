import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Models/TodoItem.dart';

class TodoDetailsPage extends StatefulWidget {
  final TodoItem todoItem;

  const TodoDetailsPage({Key key, this.todoItem}) : super(key: key);

  @override
  _TodoDetailsPageState createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Details"),
      ),
      body: Column(
        children: [
          Text(widget.todoItem.title),
          Image(image: NetworkImage(widget.todoItem.imageUrl))
        ],
      )
    );
  }
}
