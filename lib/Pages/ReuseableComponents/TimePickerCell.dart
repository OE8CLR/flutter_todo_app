import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerCell extends StatefulWidget {
  final String title;
  final DateTime dateTime;
  final EdgeInsets padding;
  final bool readOnly;
  final void Function(DateTime dateTime) onDateTimeChanged;

  TimePickerCell({Key key, @required this.title, this.dateTime, this.padding, this.readOnly = false, this.onDateTimeChanged}) : super(key: key);

  @override
  _TimePickerCellState createState() => _TimePickerCellState();
}

class _TimePickerCellState extends State<TimePickerCell> {
  bool _datePickerIsVisible = false;
  DateTime _dateTime;

  @override
  void initState() {
    _dateTime = widget.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = [
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (!widget.readOnly) {
            setState(() {
              _datePickerIsVisible = !_datePickerIsVisible;
            });
          }
        },
        child: Row(
          children: [
            Text(widget.title ?? ""),
            Flexible(child: Container()),
            Text(_dateTime != null ? DateFormat("dd.MM.yyyy kk:mm").format(_dateTime) : "whenever") // TODO: Localisation missing
          ],
        ),
      )
    ];

    if (_datePickerIsVisible) {
      elements.add(Container(
        height: 250,
        child: CupertinoDatePicker(
            use24hFormat: true,
            onDateTimeChanged: (dateTime) {
              setState(() {
                _dateTime = dateTime;
                widget.onDateTimeChanged(dateTime);
              });
            }
        ),
      ));
    }

    return Container(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        children: elements,
      )
    );
  }
}
