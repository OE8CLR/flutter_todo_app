import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Pages/ReuseableComponents/DateTimeStatusWidget.dart';
import 'package:intl/intl.dart';

class TodoListCell extends StatelessWidget {
  final String title;
  final DateTime untilDate;
  final File image;
  final bool locationAvailable;
  final bool completed;

  const TodoListCell({Key key, @required this.title, this.untilDate, this.image, this.locationAvailable = false, @required this.completed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color tintColor = completed ? Colors.grey : Colors.black;

    List<Widget> content = [];

    var firstRow = _buildFirstRow(tintColor: tintColor);
    if (firstRow.children.isNotEmpty) {
      content.add(firstRow);
    }

    var secondRow = _buildSecondRow(tintColor: tintColor);
    if (secondRow.children.isNotEmpty) {
      content.add(Container(
        padding: EdgeInsets.only(top: 8.0),
        child: secondRow,
      ));
    }

    return Container(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Column(
            children: content
        )
    );
  }

  Row _buildFirstRow({Color tintColor}) {
    List<Widget> content = [];

    // Check if an image is available and insert it in front of the text of the firstRow
    if (image != null) {
      content.add(
          Container(
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
          )
      );
    }

    // Add text that can expand to multiple lines
    content.add(
        Flexible(
            fit: FlexFit.tight,
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(title, style: TextStyle(color: tintColor)),
                    ),
                  ],
                )
            )
        )
    );

    // Add chevron or completed checkmark
    content.add(
        Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(completed ? Icons.check : Icons.chevron_right, color: tintColor)
        )
    );

    return Row(
      children: content,
    );
  }

  Row _buildSecondRow({Color tintColor}) {
    List<Widget> content = [];

    if (untilDate != null) {
      Color dateTimeTintColor = Colors.black;

      // Get the color depending on the difference to the current time
      if (!completed) {
        var difference = untilDate.difference(DateTime.now());
        if (difference.inMinutes < 0) {
          dateTimeTintColor = Colors.red;
        } else if (difference.inMinutes < 1440) {
          dateTimeTintColor = Colors.orange;
        }
      } else {
        dateTimeTintColor = tintColor;
      }

      content.add(
          DateTimeStatusWidget(
              dateTime: untilDate,
              tintColor: dateTimeTintColor
          )
      );
    }

    if (image != null) {
      content.add(
        Container(
          padding: content.isNotEmpty ? EdgeInsets.only(left: 4.0) : EdgeInsets.zero,
          child: Icon(Icons.attach_file, size: 12.0, color: tintColor),
        ),
      );
    }

    if (locationAvailable) {
      content.add(
        Container(
          padding: content.isNotEmpty ? EdgeInsets.only(left: 4.0) : EdgeInsets.zero,
          child: Icon(Icons.location_on_outlined, size: 12.0, color: tintColor),
        ),
      );
    }

    return Row(
      children: content,
    );
  }

}
