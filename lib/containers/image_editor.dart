import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ImageEditingView extends StatefulWidget {
  @override
  _ImageEditingViewState createState() => _ImageEditingViewState();
}

class _ImageEditingViewState extends State<ImageEditingView> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                )),
            Text(
              "ILPhoto",
              style: TextStyle(color: Colors.lightGreen),
            ),
            FlatButton(
                onPressed: () {},
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
        titleSpacing: 8.0,
      ),
      body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: Colors.grey,
//            child: Image.file(null),
          )),
    );
  }
}
