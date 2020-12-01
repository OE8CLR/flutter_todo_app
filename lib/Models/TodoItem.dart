import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TodoItem {
  final Uuid id;
  final String title;
  final DateTime createdDate;
  final DateTime untilDate;
  final File image;
  final double longitude;
  final double latitude;
  bool completed;
  DateTime completedDate;

  TodoItem({@required this.id, @required this.createdDate, this.title, this.untilDate, this.image, this.completed = false, this.completedDate, this.longitude, this.latitude});

}