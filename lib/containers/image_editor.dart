import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_share/redux/actions/image_editing_actions.dart';
import 'package:photo_share/redux/actions/navigation_actions.dart';
import 'package:photo_share/redux/states/app_state.dart';
import 'package:redux/redux.dart';
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
              style: TextStyle(color: Colors.white),
            ),
            FlatButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  final directory = (await getApplicationDocumentsDirectory())
                      .path; //from path_provide package
                  String fileName = DateTime.now().toIso8601String();
                  var path = '$directory/$fileName.png';
                  screenshotController
                      .capture(
                    pixelRatio: 2.0,
                    path: path,
                  )
                      .then((File image) async {
                    final result =
                        await ImageGallerySaver.save(image.readAsBytesSync());
                  }).catchError((onError) {
                    print(onError);
                  });
                },
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
          child: StoreConnector<AppState, _ViewModel>(
              converter: _ViewModel.fromStore,
              builder: (context, viewModel) {
                return Container(
//                  color: Colors.grey,
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
                                          color: Colors.grey.shade200
                                              .withOpacity(0.4),
                                        ),
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              TextField(
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true,
                                                        signed: false),
                                                decoration: InputDecoration(
                                                    hintText: "Title"),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                    hintText: "Description"),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                    hintText: "Location"),
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
  Function(File) updateSelectedImage;

  _ViewModel(
      {this.navigateToAboutUs,
      this.navigateToContactUs,
      this.navigateToImageEditor,
      this.selectedImage,
      this.updateSelectedImage});
  static _ViewModel fromStore(Store<AppState> store) {
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
        selectedImage: store.state.imageEditorState.selectedImage);
  }
}
