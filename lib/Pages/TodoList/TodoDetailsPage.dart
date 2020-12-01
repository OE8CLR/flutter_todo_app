import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Models/TodoItem.dart';
import 'package:flutter_todo_app/Network/NetworkService.dart';
import 'package:flutter_todo_app/Pages/ReuseableComponents/GoogleMapCell.dart';
import 'package:flutter_todo_app/Pages/ReuseableComponents/ImagePickerCell.dart';
import 'package:flutter_todo_app/Pages/ReuseableComponents/TimePickerCell.dart';

class TodoDetailsPage extends StatefulWidget {
  final TodoItem todoItem;

  const TodoDetailsPage({Key key, this.todoItem}) : super(key: key);

  @override
  _TodoDetailsPageState createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    if (!widget.todoItem.completed) {
      actions.add(
        FlatButton(
          onPressed: () => _completeTodo(context),
          textColor: Colors.white,
          child: Text("Complete"), // TODO: Localisation missing
          shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"), // TODO: Localisation missing
        actions: actions,
      ),
      body: ListView(
        children: _buildListView(),
      ),
    );
  }

  List<Widget> _buildListView() {
    var content = List<Widget>();

    var title = widget.todoItem?.title;
    if (title != null) {
      content.addAll([
        Divider(),
        Row(
          children: [
            Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 16.0, left: 16.0),
                      child: Text(title, style: TextStyle(fontSize: 16.0)),
                    ),
                  ],
                )
            ),
          ],
        ),
        Divider(),
      ]);
    }

    var untilDate = widget.todoItem?.untilDate;
    if (untilDate != null) {
      content.addAll([
        Divider(),
        TimePickerCell(
          dateTime: untilDate,
          padding: EdgeInsets.only(right: 16.0, left: 16.0),
          readOnly: true,
        ),
        Divider(),
      ]);
    }

    var latitude = widget.todoItem?.latitude;
    var longitude = widget.todoItem?.longitude;
    if (latitude != null && longitude != null) {
      content.addAll([
        Divider(),
        GoogleMapCell(
          padding: EdgeInsets.only(right: 16.0, left: 16.0),
          height: 200.0,
          latitude: latitude,
          longitude: longitude,
          zoomLevel: 15.0,
          readOnly: true,
        ),
        Divider(),
      ]);
    }

    var image = widget.todoItem?.image;
    if (image != null) {
      content.addAll([
        Divider(),
        ImagePickerCell(
          image: image,
          padding: EdgeInsets.only(right: 16.0, left: 16.0),
          readOnly: true,
        ),
        Divider(),
      ]);
    }

    return content;
  }

  void _completeTodo(BuildContext context) {
    // TODO: Add AlertView to check if the user really wants to complete the todo
    NetworkService().updateTodoListItem(id: widget.todoItem.id, completed: true).then((value) {
      Navigator.pop(context);
    });
  }

}
