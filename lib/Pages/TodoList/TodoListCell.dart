import 'dart:io';
import 'package:flutter/material.dart';

class TodoListCell extends StatelessWidget {
  final String title;
  final DateTime untilDate;
  final File image;
  final bool completed;

  const TodoListCell({Key key, @required this.title, this.untilDate, this.image, @required this.completed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _subviews = List<Widget>();

    // Check if an image is available and show/hide it
    if (image != null) {
      _subviews.add(Container(
          padding: EdgeInsets.only(right: 8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                  image,
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.fill
              ),
          ),
      ));
    }

    _subviews.add(Flexible(
        fit: FlexFit.tight,
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(title),
                ),
              ],
            )
        )
    ));

    // Add chevron if needed
    // FIXME: Fix issue that chevron is not aligned to the right
    _subviews.add(Container(
        padding: EdgeInsets.only(left: 8.0),
        child: Icon(completed ? Icons.check : Icons.chevron_right)
    ));

    return Container(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Row(
          children: _subviews,
        )
    );
  }

}
