import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Models/Coordinates.dart';
import 'package:geolocator/geolocator.dart';

import 'TimePickerCell.dart';

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  Coordinates _currentLocation;

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
          Container(
              padding: EdgeInsets.only(right: 16.0, left: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "I want to ...", // TODO: Localisation missing
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
                maxLines: 6,
              )
          ),
          Divider(),
          Divider(),
          Container(
            padding: EdgeInsets.only(right: 16.0, left: 16.0),
            child: TimePickerCell(
              dateTime: null,
              onDateTimeChanged: (dateTime) {
                print(dateTime);
              },
            ),
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

    Navigator.pop(context);
  }

}