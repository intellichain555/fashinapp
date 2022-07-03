import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String url;
  const ImagePreview({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Image.asset(
        url,
        fit: BoxFit.cover,
        height: size.height,
        width: size.width,
      ),
    );
  }
}
