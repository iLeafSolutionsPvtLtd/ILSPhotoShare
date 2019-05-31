import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey previewContainer = new GlobalKey();
  GlobalKey scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    takeScreenShot() async {
      RenderRepaintBoundary boundary =
          previewContainer.currentContext.findRenderObject();
      double pixelRatio = 800 / MediaQuery.of(context).size.width;
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
//      setState(() {
////        _image2 = Image.memory(pngBytes.buffer.asUint8List());
//      });

      var filePath = await ImagePickerSaver.saveFile(
          fileData: byteData.buffer.asUint8List());
//      final directory = (await getApplicationDocumentsDirectory()).path;
//      File imgFile = new File('$directory/screenshot.png');
//      imgFile.writeAsBytes(pngBytes);
//      final snackBar = SnackBar(
//        content: Text('Saved to ${filePath}'),
//        action: SnackBarAction(
//          label: 'Ok',
//          onPressed: () {
//            // Some code
//          },
//        ),
//      );
//
//      Scaffold.of(scaffoldKey.currentState.context).showSnackBar(snackBar);
    }

    return RepaintBoundary(
      key: previewContainer,
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 50,
                  ),
                  onPressed: () async {
                    var gallery = await ImagePickerSaver.pickImage(
                      source: ImageSource.camera,
                    );
                    var directory = await getApplicationDocumentsDirectory();
                    var path = directory.path;
                    File savedImage =
                        await gallery.copy('$path/saved_image.jpg');
                  }),
              IconButton(
                  icon: Icon(
                    Icons.add_photo_alternate,
                    size: 60,
                  ),
                  onPressed: () async {
                    takeScreenShot();
//                  var gallery = await ImagePicker.pickImage(
//                    source: ImageSource.gallery,
//                  );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
