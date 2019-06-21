import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_share/redux/actions/image_editing_actions.dart';
import 'package:photo_share/redux/actions/navigation_actions.dart';
import 'package:photo_share/redux/states/app_state.dart';
import 'package:photo_share/utilities/colors.dart';
import 'package:redux/redux.dart';
import 'package:screenshot/screenshot.dart';

import '../main.dart';

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
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                )),
            Text(
              "iNSTA CAPTURE",
              style: TextStyle(color: Colors.white),
            ),
            FlatButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());

                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 130.0,
                          child: Stack(
                            children: <Widget>[
                              Gradiant(),
                              Container(
                                height: 150.0,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'iNSTA CAPTURE',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Container(
                                          height: 100.0,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                  onPressed: () async {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    final directory =
                                                        (await getApplicationDocumentsDirectory())
                                                            .path; //from path_provide package
                                                    String fileName =
                                                        DateTime.now()
                                                            .toIso8601String();
                                                    var path =
                                                        '$directory/$fileName.png';
                                                    screenshotController
                                                        .capture(
                                                      pixelRatio: 2.0,
                                                      path: path,
                                                    )
                                                        .then(
                                                            (File image) async {
                                                      final ByteData bytes =
                                                          await rootBundle
                                                              .load(image.path);
                                                      await Share.file(
                                                          'esys image',
                                                          'esys.png',
                                                          bytes.buffer
                                                              .asUint8List(),
                                                          'image/png');
                                                    }).catchError((onError) {
                                                      print(onError);
                                                    });
                                                  },
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                    style: BorderStyle.none,
                                                  )),
                                                  color: Colors.white,
                                                  child: Icon(
                                                    Icons.share,
                                                    color: iLColors.phoneColor,
                                                  )),
                                              FlatButton(
                                                  onPressed: () async {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    final directory =
                                                        (await getApplicationDocumentsDirectory())
                                                            .path; //from path_provide package
                                                    String fileName =
                                                        DateTime.now()
                                                            .toIso8601String();
                                                    var path =
                                                        '$directory/$fileName.png';
                                                    screenshotController
                                                        .capture(
                                                      pixelRatio: 2.0,
                                                      path: path,
                                                    )
                                                        .then(
                                                            (File image) async {
                                                      final result =
                                                          await ImageGallerySaver
                                                              .save(image
                                                                  .readAsBytesSync());
                                                      print(result);
                                                    }).catchError((onError) {
                                                      print(onError);
                                                    });
                                                  },
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                    style: BorderStyle.none,
                                                  )),
                                                  color: Colors.white,
                                                  child: Icon(
                                                    Icons.save,
                                                    color: iLColors.phoneColor,
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        );
                      });
//
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                )),
          ],
        ),
        backgroundColor: iLColors.gradient2,
        automaticallyImplyLeading: false,
        titleSpacing: 8.0,
      ),
      body: Screenshot(
          controller: screenshotController,
          child: StoreConnector<AppState, _ViewModel>(
              converter: _ViewModel.fromStore,
              builder: (context, viewModel) {
                return Container(
                  child: viewModel.selectedImage == null
                      ? CircularProgressIndicator()
                      : Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Image.file(
                                  viewModel.selectedImage,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: BackdropFilter(
                                      filter: ui.ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade900
                                              .withOpacity(0.3),
                                        ),
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/logo.png',
                                                height: 30.0,
                                                width: 30.0,
                                              ),
                                              TextField(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText: "Title",
                                                    border: UnderlineInputBorder(
                                                        borderSide:
                                                            new BorderSide(
                                                                color: iLColors
                                                                    .gradient2)),
                                                    hintStyle: TextStyle(
                                                      color: Colors.white,
                                                    )),
                                              ),
                                              TextField(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText: "Description",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: Text(
                                                  viewModel.locationName,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: Text(
                                                  viewModel.time,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                );
              })),
    );
  }
}

class _ViewModel {
  Function navigateToAboutUs;
  Function navigateToContactUs;
  Function navigateToImageEditor;
  File selectedImage;
  String locationName;
  String time;
  Function(File) updateSelectedImage;

  _ViewModel(
      {this.navigateToAboutUs,
      this.navigateToContactUs,
      this.navigateToImageEditor,
      this.selectedImage,
      this.updateSelectedImage,
      this.locationName,
      this.time});
  static _ViewModel fromStore(Store<AppState> store) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').add_jms().format(now);
    return _ViewModel(
        navigateToAboutUs: () {
          store.dispatch(NavigateToAboutUsPage());
        },
        navigateToContactUs: () {
          store.dispatch(NavigateToContactUsPage());
        },
        navigateToImageEditor: () {
          store.dispatch(NavigateToImageEditingPage());
        },
        updateSelectedImage: (imageFile) {
          store.dispatch(UpdateSelectedImage(image: imageFile));
        },
        locationName: store.state.imageEditorState.locationName,
        time: formattedDate,
        selectedImage: store.state.imageEditorState.selectedImage);
  }
}
