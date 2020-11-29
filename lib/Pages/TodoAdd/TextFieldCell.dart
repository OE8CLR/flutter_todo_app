import 'package:flutter/material.dart';

class TextFieldCell extends StatefulWidget {
  final String hintText;
  final EdgeInsets padding;
  final void Function(String text) onTextChanged;

  const TextFieldCell({Key key, @required this.hintText, @required this.onTextChanged, this.padding}) : super(key: key);

  @override
  _TextFieldCellState createState() => _TextFieldCellState();
}

class _TextFieldCellState extends State<TextFieldCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding ?? EdgeInsets.zero,
        child: TextField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          maxLines: 6,
          onChanged: widget.onTextChanged,
        )
    );
  }
}
