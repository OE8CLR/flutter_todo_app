import 'dart:io';
import 'package:flutter/material.dart';
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
    List<Widget> content = [];

    var firstRow = _buildFirstRow();
    if (firstRow.children.isNotEmpty) {
      content.add(firstRow);
    }

    var secondRow = _buildSecondRow();
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

  Row _buildFirstRow() {
    List<Widget> content = [
      Flexible(
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
      ),
      Container(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(completed ? Icons.check : Icons.chevron_right)
      )
    ];

    // Check if an image is available and insert it in front of the text of the firstRow
    if (image != null) {
      content.insert(0, Container(
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

    return Row(
      children: content,
    );
  }

  Row _buildSecondRow() {
    List<Widget> content = [];

    if (untilDate != null) {
      Color dateTimeColor = Colors.grey;

      // Get the color depending on the difference to the current time
      var difference = untilDate.difference(DateTime.now());
      if (difference.inMinutes < 0) {
        dateTimeColor = Colors.red;
      } else if (difference.inMinutes < 1440) {
        dateTimeColor = Colors.orange;
      }

      content.add(
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: dateTimeColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Container(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 2.0),
                        child: Icon(
                          Icons.calendar_today,
                          size: 12.0,
                          color: dateTimeColor,
                        ),
                      ),
                      Text(
                        DateFormat("dd.MM. kk:mm").format(untilDate),
                        style: TextStyle(fontSize: 10.0, color: dateTimeColor),
                      )
                    ],
                  )
              )
          ),
      );
    }

    if (image != null) {
      content.add(
        Container(
          padding: content.isNotEmpty ? EdgeInsets.only(left: 4.0) : EdgeInsets.zero,
          child: Icon(Icons.attach_file, size: 12.0, color: Colors.grey),
        ),
      );
    }

    if (locationAvailable) {
      content.add(
        Container(
          padding: content.isNotEmpty ? EdgeInsets.only(left: 4.0) : EdgeInsets.zero,
          child: Icon(Icons.location_on_outlined, size: 12.0, color: Colors.grey),
        ),
      );
    }

    return Row(
      children: content,
    );
  }

}
