import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_villains/villain.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_share/containers/image_editor.dart';
import 'package:photo_share/redux/actions/navigation_actions.dart';
import 'package:photo_share/redux/middlewares/app_middleware.dart';
import 'package:photo_share/redux/reducers/app_state_reducer.dart';
import 'package:photo_share/redux/states/app_state.dart';
import 'package:photo_share/utilities/keys.dart';
import 'package:redux/redux.dart';

import 'containers/about_us.dart';
import 'containers/contact_us.dart';

void main() => runApp(MyAppBase());

final Store<AppState> store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initial(),
  middleware: appMiddleware(),
);

class MyAppBase extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [new VillainTransitionObserver()],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        navigatorKey: Keys.navKey,
        routes: <String, WidgetBuilder>{
          "/ContactUsView": (BuildContext context) => ContactUsView(),
          "/AboutUsView": (BuildContext context) => AboutUsView(),
          "/ImageEditingView": (BuildContext context) => ImageEditingView(),
        },
      ),
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
  var icons = [
    "assets/camera.png",
    "assets/gallery.png",
    "assets/info.png",
    "assets/contact.png",
  ];
  var titles = ["Camera", "Gallery", "About us", "Contact us"];
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
                              child: Villain(
                                villainAnimation: VillainAnimation.fromLeft(
                                  offset: 1.0 - index / 40,
                                  from: Duration(milliseconds: 100),
                                  to: Duration(seconds: 1),
                                ),
                                animateExit: false,
                                secondaryVillainAnimation:
                                    VillainAnimation.fade(),
                                child: GridTile(
                                  child: StoreConnector<AppState, _ViewModel>(
                                    converter: _ViewModel.fromStore,
                                    distinct: true,
                                    builder: (context, viewModel) {
                                      return GridItem(
                                        didSelect: (index) async {
                                          switch (index) {
                                            case 0:
                                              var image =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (image != null) {
                                                var directory =
                                                    await getApplicationDocumentsDirectory();
                                                var path = directory.path;
                                                File savedImage =
                                                    await image.copy(
                                                        '$path/saved_image.jpg');
                                                viewModel
                                                    .navigateToImageEditor();
                                              }

                                              return;
                                            case 1:
                                              var image =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (image != null) {
                                                var directory =
                                                    await getApplicationDocumentsDirectory();
                                                var path = directory.path;
                                                File savedImage =
                                                    await image.copy(
                                                        '$path/saved_image.jpg');
                                                viewModel
                                                    .navigateToImageEditor();
                                              }
                                              return;
                                            case 2:
                                              viewModel.navigateToAboutUs();
                                              return;
                                            case 3:
                                              viewModel.navigateToContactUs();
                                              return;
                                          }

//                                    var gallery =
//                                        await ImagePickerSaver.pickImage(
//                                      source: ImageSource.gallery,
//                                    );

                                          //savedImage.writeAsBytes(null);
                                        },
                                        icon: icons[index],
                                        title: titles[index],
                                        index: index,
                                      );
                                    },
                                  ),
                                ),
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

class _ViewModel {
  Function navigateToAboutUs;
  Function navigateToContactUs;
  Function navigateToImageEditor;
  _ViewModel(
      {this.navigateToAboutUs,
      this.navigateToContactUs,
      this.navigateToImageEditor});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(navigateToAboutUs: () {
      store.dispatch(NavigateToAboutUsPage());
    }, navigateToContactUs: () {
      store.dispatch(NavigateToContactUsPage());
    }, navigateToImageEditor: () {
      store.dispatch(NavigateToImageEditingPage());
    });
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

//    var filePath = await ImagePickerSaver.saveFile(
//        fileData: byteData.buffer.asUint8List());
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
          child: new GridItem(
            didSelect: (index) async {},
          ),
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
  final int index;
  final Function(int) didSelect;
  final String icon;
  final title;
  const GridItem({Key key, this.didSelect, this.title, this.icon, this.index})
      : super(key: key);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  iconSize: 50,
                  icon: Image.asset(
                    icon,
                    width: 30.0,
                    height: 30.0,
                  ),
                  onPressed: () async {
                    didSelect(index);
                  }),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
