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
    return RepaintBoundary(
      key: previewContainer,
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blue,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  'assets/8478.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                ),
                Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: GridView.builder(
                          itemCount: 4,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridTile(
                                child: GridItem(),
                              ),
                            );
                          }),
                      height: MediaQuery.of(context).size.height * 0.57,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatefulWidget {
  final GlobalKey previewContainer;
  const NewWidget({Key key, this.previewContainer}) : super(key: key);

  @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  takeScreenShot() async {
    RenderRepaintBoundary boundary =
        widget.previewContainer.currentContext.findRenderObject();
    double pixelRatio = 800 / MediaQuery.of(context).size.width;
    ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: new GridItem(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ClipRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: (MediaQuery.of(context).size.width / 2),
                height: (MediaQuery.of(context).size.width / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.grey.shade200.withOpacity(0.4),
                ),
                child: IconButton(
                    icon: Icon(
                      Icons.add_photo_alternate,
                      size: 60,
                    ),
                    onPressed: () async {
                      takeScreenShot();
//                    var gallery = await ImagePickerSaver.pickImage(
//                      source: ImageSource.gallery,
//                    );
                    }),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.grey.shade200.withOpacity(0.4),
          ),
          width: (MediaQuery.of(context).size.width / 2) - 24,
          height: (MediaQuery.of(context).size.width / 2) - 24,
          child: IconButton(
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
                File savedImage = await gallery.copy('$path/saved_image.jpg');
              }),
        ),
      ),
    );
  }
}
