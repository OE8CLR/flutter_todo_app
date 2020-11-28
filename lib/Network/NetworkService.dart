import 'package:flutter_todo_app/Models/TodoItem.dart';

class NetworkService {

  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;

  var todoItems = List<TodoItem>();

  // init things for singleton
  NetworkService._internal() {
    // Init todoItems
    todoItems.addAll([
      TodoItem(
          title: "I really need to check where i can find this beautiful owl.",
          untilDate: DateTime.fromMillisecondsSinceEpoch(1574972656),
          imageUrl: "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
          completed: false
      ),
      TodoItem(
          title: "I really need to check where i can find this beautiful owl.",
          untilDate: DateTime.fromMillisecondsSinceEpoch(1590697456),
          imageUrl: "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
          completed: false
      ),
      TodoItem(
          title: "I really need to check where i can find this beautiful owl.",
          untilDate: DateTime.now(),
          completed: false
      ),
      TodoItem(
          title: "I really need to check where i can find this beautiful owl.",
          untilDate: DateTime.fromMillisecondsSinceEpoch(1601324656),
          completed: true
      ),
    ]);
  }

  Future<List<TodoItem>> getTodoListItems() async {
    return todoItems;
  }

  // Future<TodoItem> addTodoListItem({String title, String imageUrl, DateTime untilDate, double longitude, double latitude}) async {
  //
  // }
  //
  // Future<TodoItem> updateTodoListItem({String id, bool completed}) async {
  //
  // }

}