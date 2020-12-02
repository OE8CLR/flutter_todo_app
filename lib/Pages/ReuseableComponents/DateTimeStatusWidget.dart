import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeStatusWidget extends StatelessWidget {
  final Color tintColor;
  final DateTime dateTime;

  const DateTimeStatusWidget({Key key, @required this.dateTime, this.tintColor = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: tintColor,
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
                    color: tintColor,
                  ),
                ),
                Text(
                  DateFormat("dd.MM. kk:mm").format(dateTime), // TODO: Localisation missing
                  style: TextStyle(fontSize: 10.0, color: tintColor),
                )
              ],
            )
        )
    );
  }

}
