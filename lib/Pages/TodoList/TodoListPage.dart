import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Models/TodoItem.dart';
import 'package:flutter_todo_app/Network/NetworkService.dart';
import 'package:flutter_todo_app/Pages/TodoList/TodoAddPage.dart';
import 'package:flutter_todo_app/Pages/TodoList/TodoDetailsPage.dart';
import 'package:flutter_todo_app/Pages/ReuseableComponents/TodoListCell.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  Future<List<TodoItem>> _items;

  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo's"), // TODO: Localisation missing
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
              ).then((value) {
                // Reload view after view was popped
                setState(() => _loadItems());
              });
            },
            padding: EdgeInsets.only(right: 20.0),
          ),
        ]
      ),
      body: FutureBuilder(
        future: _items,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return Container(
            padding: EdgeInsets.only(top: 8.0), // Add some padding to the top, otherwise the first cell will look really wired
            child: ListView.builder(
              itemCount: snapshot.data.length * 2,  // Use double amount because we will insert a Divider in the ItemBuilder
              itemBuilder: (context, index) => _listViewItemBuilder(context, snapshot, index),
            ),
          );
        }
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, AsyncSnapshot<List<TodoItem>> snapshot, int index) {
    // Check if we have an even number, because we want to insert a Divider after each cell.
    if (index.isOdd) return Divider();
    var _item = snapshot.data[index ~/ 2];

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodoDetailsPage(todoItem: _item)
            )
        ).then((value) {
          // Reload view after view was popped
          setState(() => _loadItems());
        });
      },
      child: TodoListCell(
        title: _item.title,
        image: _item.image,
        untilDate: _item.untilDate,
        completed: _item.completed,
      ),
    );
  }

  void _loadItems() {
    _items = NetworkService().getTodoListItems();
  }

}
