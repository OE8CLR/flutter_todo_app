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

          // Sort the received data, so that the nearest untilWhen date is first
          List<TodoItem> sortedList = snapshot.data;
          sortedList.sort(_sortTodoItem);

          return Container(
            padding: EdgeInsets.only(top: 8.0), // Add some padding to the top, otherwise the first cell will look really wired
            child: ListView.builder(
              itemCount: sortedList.length * 2,  // Use double amount because we will insert a Divider in the ItemBuilder
              itemBuilder: (context, index) => _listViewItemBuilder(context, sortedList, index),
            ),
          );
        }
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, List<TodoItem> items, int index) {
    // Check if we have an even number, because we want to insert a Divider after each cell.
    if (index.isOdd) return Divider();
    var item = items[index ~/ 2];

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodoDetailsPage(todoItem: item)
            )
        ).then((value) {
          // Reload view after view was popped
          setState(() => _loadItems());
        });
      },
      child: TodoListCell(
        title: item.title,
        image: item.image,
        untilDate: item.untilDate,
        locationAvailable: (item.longitude != null && item.latitude != null),
        completed: item.completed,
      ),
    );
  }

  void _loadItems() {
    _items = NetworkService().getTodoListItems();
  }

  /* Sorting Pattern:
  *  - ITEM (nearest untilDate, not completed)
  *  - ITEM (farthest untilDate, not completed)
  *  - ITEM (no untilDate, oldest createdDate, not completed)
  *  - ITEM (no untilDate, newest createdDate, not completed)
  *  - ITEM (completed, newest completedDate)
  *  - ITEM (completed, oldest completedDate)
  */
  int _sortTodoItem(TodoItem a, TodoItem b) {
    if (a.completed && b.completed) {
      // Reversed sorting (DESC) because we want that the newest completed todoItem is on top
      return b.completedDate.compareTo(a.completedDate);
    } else if (a.completed) {
      return 1;
    } else if (b.completed) {
      return -1;
    }

    if (a.untilDate == null && b.untilDate == null) {
      // If both untilDates are null then check the created date for sorting (newest first)
      return a.createdDate.compareTo(b.createdDate);
    } else if (a.untilDate == null) {
      return 1;
    } else if (b.untilDate == null) {
      return -1;
    }
    return a.untilDate?.compareTo(b.untilDate);
  }

}
