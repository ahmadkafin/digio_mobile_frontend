import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageConvertWidget extends StatefulWidget {
  const ImageConvertWidget({super.key, required this.base64Image});
  final String base64Image;
  @override
  State<ImageConvertWidget> createState() => _ImageConvertWidgetState();
}

class _ImageConvertWidgetState extends State<ImageConvertWidget> {
  late final Uint8List _imageBytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageBytes = base64Decode(widget.base64Image);
  }

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      _imageBytes,
      cacheWidth: 200,
      fit: BoxFit.cover,
    );
  }
}
