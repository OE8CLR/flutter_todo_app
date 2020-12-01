import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCell extends StatefulWidget {
  final File image;
  final EdgeInsets padding;
  final bool readOnly;
  final void Function(File image) imageSelected;

  const ImagePickerCell({Key key, this.image, this.padding, this.readOnly = false, this.imageSelected}) : super(key: key);

  @override
  _ImagePickerCellState createState() => _ImagePickerCellState();
}

class _ImagePickerCellState extends State<ImagePickerCell> {
  final imagePicker = ImagePicker();
  File _image;

  @override
  void initState() {
    _image = widget.image;
    super.initState();
  }

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
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (!widget.readOnly) {
            _showImagePickerActionSheet(context);
          }
        },
        child: Row (
          children: [
            _child
          ],
        ),
      ),
    );
  }

  void _showImagePickerActionSheet(BuildContext context) {
    // FIXME: Background color of actionSheets
    // https://github.com/flutter/flutter/issues/24687
    showModalBottomSheet(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _openImagePicker(ImageSource.camera);
              },
              child: Text("Camera") // TODO: Localisation missing
          ),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _openImagePicker(ImageSource.gallery);
              },
              child: Text("Gallery") // TODO: Localisation missing
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"), // TODO: Localisation missing
          isDefaultAction: true,
        ),
      ),
    );
  }

  void _openImagePicker(ImageSource source) {
    imagePicker.getImage(source: source).then((file) {
      if (file?.path != null) {
        setState(() {
          _image = File(file.path);
          widget.imageSelected(_image);
        });
      }
    });
  }

}
