import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_villains/villain.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:permission/permission.dart';
import 'package:photo_share/containers/image_editor.dart';
import 'package:photo_share/redux/actions/image_editing_actions.dart';
import 'package:photo_share/redux/actions/navigation_actions.dart';
import 'package:photo_share/redux/middlewares/app_middleware.dart';
import 'package:photo_share/redux/reducers/app_state_reducer.dart';
import 'package:photo_share/redux/states/app_state.dart';
import 'package:photo_share/utilities/colors.dart';
import 'package:photo_share/utilities/keys.dart';
import 'package:redux/redux.dart';

import 'containers/about_us.dart';
import 'containers/contact_us.dart';
import 'containers/splash_screen.dart';

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
    timeDilation = 8.0;
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [new VillainTransitionObserver()],
        theme: ThemeData(
          fontFamily: "JTLeonor",
        ),
        home: CustomSplashScreen(
            errorSplash: Container(),
            backgroundColor: Colors.green,
            loadingSplash: Stack(
              children: <Widget>[
                Gradiant(),
                Center(
                    child: Hero(
                        tag: "dds", child: Image.asset('assets/logo.png'))),
              ],
            ),
            seconds: 1,
            home: MyHomePage()),
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
    timeDilation = 1.0;
    return RepaintBoundary(
//      key: previewContainer,
      child: Scaffold(
//        key: scaffoldKey,
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blue,
            child: Stack(
              children: <Widget>[
                Gradiant(),
                Center(
                    child: StoreConnector<AppState, _ViewModel>(
                        converter: _ViewModel.fromStore,
                        builder: (context, viewModel) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Hero(
                                        child: Image.asset('assets/logo.png'),
                                        tag: "dds",
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0,
                                            bottom: 20.0,
                                            top: 15.0),
                                        child: Text(
                                          'iNSTA CAPTURE',
                                          style: TextStyle(
                                              fontFamily: 'JTLeonor',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 50.0),
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              viewModel.navigateToAboutUs();
                                            },
                                            shape: CircleBorder(
                                                side: BorderSide(
                                              style: BorderStyle.none,
                                            )),
                                            color: Colors.white,
                                            child: Icon(
                                              Icons.info_outline,
                                              color: iLColors.phoneColor,
                                            )),
                                        Text(
                                          'About us',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        ButtonTheme(
                                            height: 100.0,
                                            child: FlatButton(
                                                onPressed: () async {
                                                  LocationData currentLocation;

                                                  var location = new Location();
                                                  if (await location
                                                      .hasPermission()) {
                                                    currentLocation =
                                                        await location
                                                            .getLocation();
                                                    if (currentLocation !=
                                                        null) {
                                                      final coordinates =
                                                          new Coordinates(
                                                              currentLocation
                                                                  .latitude,
                                                              currentLocation
                                                                  .longitude);
                                                      var addresses = await Geocoder
                                                          .local
                                                          .findAddressesFromCoordinates(
                                                              coordinates);
                                                      viewModel
                                                          .updateLocationName(
                                                              addresses.first
                                                                  .addressLine);
                                                    }
                                                  } else {
                                                    var a = location
                                                        .requestPermission()
                                                        .then((status) async {
                                                      if (status) {
                                                        currentLocation =
                                                            await location
                                                                .getLocation();
                                                        if (currentLocation !=
                                                            null) {
                                                          final coordinates =
                                                              new Coordinates(
                                                                  currentLocation
                                                                      .latitude,
                                                                  currentLocation
                                                                      .longitude);
                                                          var addresses =
                                                              await Geocoder
                                                                  .local
                                                                  .findAddressesFromCoordinates(
                                                                      coordinates);
                                                          print(addresses);
                                                        }
                                                      }
                                                    });
                                                  }

                                                  if (Platform.isAndroid) {
                                                    var permissionNames =
                                                        await Permission
                                                            .requestPermissions([
                                                      PermissionName.Storage,
                                                    ]);

                                                    switch (permissionNames
                                                        .first
                                                        .permissionStatus) {
                                                      case PermissionStatus
                                                          .allow:
                                                        await showCamera(
                                                            viewModel);
                                                        // TODO: Handle this case.
                                                        break;
                                                      case PermissionStatus
                                                          .deny:
                                                        Permission
                                                            .openSettings();

                                                        // TODO: Handle this case.

                                                        break;
                                                      case PermissionStatus
                                                          .notDecided:
                                                        Permission
                                                            .openSettings();

                                                        // TODO: Handle this case.
                                                        break;
                                                      case PermissionStatus
                                                          .notAgain:
                                                        Permission
                                                            .openSettings();

                                                        // TODO: Handle this case.
                                                        break;
                                                      case PermissionStatus
                                                          .whenInUse:
                                                        Permission
                                                            .openSettings();
                                                        // TODO: Handle this case.
                                                        break;
                                                      case PermissionStatus
                                                          .always:
                                                        await showCamera(
                                                            viewModel);
                                                        // TODO: Handle this case.
                                                        break;
                                                    }
                                                  } else {
                                                    await showCamera(viewModel);
                                                  }
                                                },
                                                color: Colors.white,
                                                shape: CircleBorder(
                                                    side: BorderSide(
                                                  style: BorderStyle.none,
                                                )),
                                                child: Icon(
                                                  Icons.photo_camera,
                                                  color: iLColors.camBlue,
                                                ))),
                                        Text(
                                          'Camera',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              viewModel.navigateToContactUs();
                                            },
                                            color: Colors.white,
                                            shape: CircleBorder(
                                                side: BorderSide(
                                              style: BorderStyle.none,
                                            )),
                                            child: Icon(
                                              Icons.phone,
                                              color: iLColors.phoneColor,
                                              size: 15.0,
                                            )),
                                        Text(
                                          'Contact us',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future showCamera(_ViewModel viewModel) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      viewModel.updateSelectedImage(image);
      viewModel.navigateToImageEditor();
    }
  }
}

class Gradiant extends StatelessWidget {
  const Gradiant({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Add box decoration
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.0, 1.0],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            iLColors.gradient1,
            iLColors.gradient2
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  Function navigateToAboutUs;
  Function navigateToContactUs;
  Function navigateToImageEditor;
  Function(File) updateSelectedImage;
  Function(String) updateLocationName;
  _ViewModel(
      {this.navigateToAboutUs,
      this.navigateToContactUs,
      this.navigateToImageEditor,
      this.updateSelectedImage,
      this.updateLocationName});
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(navigateToAboutUs: () {
      store.dispatch(NavigateToAboutUsPage());
    }, navigateToContactUs: () {
      store.dispatch(NavigateToContactUsPage());
    }, navigateToImageEditor: () {
      store.dispatch(NavigateToImageEditingPage());
    }, updateSelectedImage: (imageFile) {
      store.dispatch(UpdateSelectedImage(image: imageFile));
    }, updateLocationName: (locationName) {
      store.dispatch(UpdateLocationName(name: locationName));
    });
  }
}
