import 'package:flutter/material.dart';

class TodoListCell extends StatelessWidget {
  final String title;
  final DateTime untilDate;
  final ImageProvider<Object> image;
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
              child: Image(
                width: 50.0,
                image: image,
              )
          )
      ));
    }

    _subviews.add(Flexible(
        child: Container(
            child: Column(
              children: [
                Text(title)
              ],
            )
        )
    ));

    // Add chevron if needed
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
