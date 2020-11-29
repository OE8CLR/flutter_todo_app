import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCell extends StatefulWidget {
  final EdgeInsets padding;
  final void Function(File image) imageSelected;

  const ImagePickerCell({Key key, this.padding, @required this.imageSelected}) : super(key: key);

  @override
  _ImagePickerCellState createState() => _ImagePickerCellState();
}

class _ImagePickerCellState extends State<ImagePickerCell> {
  final imagePicker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    Widget _child;

    if (_image == null) {
      _child = Text("Select image ..."); // TODO: Localisation missing
    } else {
      _child = Flexible(
        child: Image.file(_image),
      );
    }

    return Container(
      padding: widget.padding ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: _getImage,
        child: Row (
          children: [
            _child
          ],
        ),
      ),
    );
  }

  void _getImage() {
    imagePicker.getImage(source: ImageSource.gallery).then((file) {
      if (file?.path != null) {
        setState(() {
          _image = File(file.path);
          widget.imageSelected(_image);
        });
      }
    });
  }

}
