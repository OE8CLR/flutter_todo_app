import 'dart:io';
import 'package:flutter_todo_app/Models/TodoItem.dart';
import 'package:uuid/uuid.dart';

class NetworkService {

  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;

  var todoItems = List<TodoItem>();

  // init things for singleton
  NetworkService._internal() {
    // Init todoItems
    todoItems.addAll([
      TodoItem(
          id: Uuid(),
          title: "I really need to checkout that cool working place.",
          createdDate: DateTime.now(),
          untilDate: DateTime.now().add(Duration(days: 1)),
          latitude: 47.34355887611109,
          longitude: 13.200706934456012,
          image: null,
          completed: false
      ),
    ]);
  }

  Future<List<TodoItem>> getTodoListItems() async {
    return todoItems;
  }

  Future<TodoItem> addTodoListItem({String title, File image, DateTime untilDate, double longitude, double latitude}) async {
    var retVal = TodoItem(
      id: Uuid(),
      title: title,
      image: image,
      untilDate: untilDate,
      createdDate: DateTime.now(),
      longitude: longitude,
      latitude: latitude
    );

    // Store item for further runtime useage
    todoItems.add(retVal);

    return retVal;
  }

  Future<TodoItem> updateTodoListItem({Uuid id, bool completed}) async {
    var retVal = todoItems.firstWhere((element) => element.id == id);
    if (retVal == null) {
      throw Exception("TodoItem not found");
    }

    // Update state
    retVal.completed = completed;

    return retVal;
  }

}