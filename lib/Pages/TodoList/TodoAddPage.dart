import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Models/Coordinates.dart';
import 'package:flutter_todo_app/Network/NetworkService.dart';
import 'package:flutter_todo_app/Pages/ReuseableComponents/ImagePickerCell.dart';
import 'package:flutter_todo_app/Pages/ReuseableComponents/TextFieldCell.dart';
import 'package:geolocator/geolocator.dart';

import '../ReuseableComponents/TimePickerCell.dart';

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  String _todoText;
  DateTime _untilDate;
  Coordinates _currentLocation;
  File _image;

  @override
  void initState() {
    _getUsersLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"), // TODO: Localisation missing
        actions: [
          FlatButton(
            onPressed: () => _createNewTodo(context),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            textColor: Colors.white,
            child: Text("Create"), // TODO: Localisation missing
          ),
        ],
      ),
      body: ListView(
        children: [
          Divider(),
          TextFieldCell(
            padding: EdgeInsets.only(right: 16.0, left: 16.0),
            hintText: "I want to ...", // TODO: Localisation missing
            onTextChanged: (text) => _todoText = text,
          ),
          Divider(),
          Divider(),
          TimePickerCell(
            padding: EdgeInsets.only(right: 16.0, left: 16.0),
            onDateTimeChanged: (dateTime) => _untilDate = dateTime,
          ),
          Divider(),
          Divider(),
          ImagePickerCell(
            padding: EdgeInsets.only(right: 16.0, left: 16.0),
            imageSelected: (image) => _image = image,
          ),
          Divider(),
        ],
      ),
    );
  }

  void _getUsersLocation() {
    Geolocator.requestPermission().then((permission) {
      if (permission != LocationPermission.denied) {
        Geolocator.getCurrentPosition().then((position) {
          print("Received users location: $position");
          _currentLocation = Coordinates(
              latitude: position.latitude,
              longitude: position.longitude
          );
        });
      }
    });
  }

  void _createNewTodo(BuildContext context) {
    // TODO: Validate input parameters

    NetworkService().addTodoListItem(
        title: _todoText,
        untilDate: _untilDate,
        image: _image,
        longitude: _currentLocation.longitude,
        latitude: _currentLocation.latitude
    ).then((todoItem) {
      Navigator.pop(context);
    });
  }

}