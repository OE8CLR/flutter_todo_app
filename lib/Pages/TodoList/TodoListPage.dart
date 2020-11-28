import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Models/TodoItem.dart';
import 'package:flutter_todo_app/Pages/TodoAdd/TodoAddPage.dart';
import 'package:flutter_todo_app/Pages/TodoDetails/TodoDetailsPage.dart';
import 'package:flutter_todo_app/Pages/TodoList/TodoListCell.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  var items = [
    TodoItem(
        "I really need to check where i can find this beautiful owl.",
        DateTime.now(),
        "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
        false),
    TodoItem(
        "I really need to check where i can find this beautiful owl.",
        DateTime.now(),
        "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
        false),
    TodoItem(
        "I really need to check where i can find this beautiful owl.",
        DateTime.now(),
        null,
        false),
    TodoItem(
        "I really need to check where i can find this beautiful owl.",
        DateTime.now(),
        null,
        true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo's"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodoAddPage(),
                      fullscreenDialog: true
                  )
              );
            },
            padding: EdgeInsets.only(right: 20.0),
          ),
        ]
      ),
      body: ListView.builder(
          itemCount: items.length * 2,  // Use double amount because we will insert a Divider in the ItemBuilder
          itemBuilder: _listViewItemBuilder,
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    // Check if we have an even number, because we want to insert a Divider after each cell.
    if (index.isOdd) return Divider();
    var _item = items[index ~/ 2];

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodoDetailsPage(todoItem: _item)
            )
        );
      },
      child: TodoListCell(
        title: _item.title,
        image: _item.imageUrl != null ? NetworkImage(_item.imageUrl) : null,
        untilDate: _item.untilDate,
        completed: _item.completed,
      ),
    );
  }

  void addTodoButtonPressed() {
    print("add new todo button pressed");
  }

}
