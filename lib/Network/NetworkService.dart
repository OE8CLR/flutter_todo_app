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
          id: Uuid().toString(),
          title: "I really need to check where i can find this beautiful owl.",
          untilDate: DateTime.now().add(Duration(days: 1)),
          imageUrl: "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
          completed: false
      ),
    ]);
  }

  Future<List<TodoItem>> getTodoListItems() async {
    return todoItems;
  }

  Future<TodoItem> addTodoListItem({String title, String imageUrl, DateTime untilDate, double longitude, double latitude}) async {
    var retVal = TodoItem(
      id: Uuid().toString(),
      title: title,
      imageUrl: imageUrl,
      untilDate: untilDate,
      longitude: longitude,
      latitude: latitude
    );

    // Store item for further runtime useage
    todoItems.add(retVal);

    return retVal;
  }

  // Future<TodoItem> updateTodoListItem({String id, bool completed}) async {
  //
  // }

}