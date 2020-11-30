import 'package:flutter/material.dart';

class TextFieldCell extends StatefulWidget {
  final String text;
  final String hintText;
  final EdgeInsets padding;
  final bool readOnly;
  final void Function(String text) onTextChanged;

  const TextFieldCell({Key key, this.text, @required this.hintText, this.padding, this.readOnly = false, @required this.onTextChanged}) : super(key: key);

  @override
  _TextFieldCellState createState() => _TextFieldCellState();
}

class _TextFieldCellState extends State<TextFieldCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding ?? EdgeInsets.zero,
        child: TextField(
          controller: TextEditingController()..text = widget.text,
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          maxLines: 6,
          onChanged: widget.onTextChanged,
          readOnly: widget.readOnly,
        )
    );
  }
}
