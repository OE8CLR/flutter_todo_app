import 'package:flutter/material.dart';

class TodoItem {
  final String id;
  final String title;
  final DateTime untilDate;
  final String imageUrl;
  final double longitude;
  final double latitude;
  bool completed;

  TodoItem({@required this.id, this.title, this.untilDate, this.imageUrl, this.completed = false, this.longitude, this.latitude});

}