import 'package:flutter/material.dart';

import '../../../../themes/color.dart';



class ImageViewer extends StatefulWidget {
  final String img;
  const ImageViewer({Key? key, required this.img}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primarycolor1,
      ),
      body: InteractiveViewer(
        scaleEnabled: true,
        child: Center(
          child: Image.network(widget.img),
        ),
      ),
    );
  }
}
