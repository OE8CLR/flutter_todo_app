import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoListCell extends StatelessWidget {
  final String title;
  final DateTime untilDate;
  final File image;
  final bool completed;

  const TodoListCell({Key key, @required this.title, this.untilDate, this.image, @required this.completed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Layout firstRowContent
    List<Widget> firstRowContent = [
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
      firstRowContent.insert(0, Container(
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

    // Layout secondRow Content
    Widget secondRowContent = Container();

    if (untilDate != null) {
      Color dateTimeColor;
      if (untilDate.difference(DateTime.now()).inMinutes < 0) {
        dateTimeColor = Colors.red;
      } else if (untilDate.difference(DateTime.now()).inMinutes < 1440) {
        dateTimeColor = Colors.orange;
      } else {
        dateTimeColor = Colors.grey;
      }

      secondRowContent = Container(
        padding: EdgeInsets.only(top: 6.0),
        child: Row(
          children: [
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
                            style: TextStyle(fontSize: 10.0, color: dateTimeColor)
                        )
                      ],
                    )
                )
            ),
          ],
        ),
      );
    }

    return Container(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Column(
            children: [
              Row(
                children: firstRowContent,
              ),
              secondRowContent
            ]
        )
    );
  }

}
