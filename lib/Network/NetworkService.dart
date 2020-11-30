import 'dart:io';

import 'package:flutter_todo_app/Models/TodoItem.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

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
          title: "I really need to check where i can find this beautiful owl.",
          untilDate: DateTime.now().add(Duration(days: 1)),
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