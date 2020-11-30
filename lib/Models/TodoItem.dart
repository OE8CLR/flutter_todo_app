import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TodoItem {
  final Uuid id;
  final String title;
  final DateTime untilDate;
  final File image;
  final double longitude;
  final double latitude;
  bool completed;

  TodoItem({@required this.id, this.title, this.untilDate, this.image, this.completed = false, this.longitude, this.latitude});

}