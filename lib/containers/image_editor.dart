import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
          child: StoreConnector<AppState, _ViewModel>(
              converter: _ViewModel.fromStore,
              builder: (context, viewModel) {
                return Container(
                  color: Colors.grey,
                  child: viewModel.selectedImage == null
                      ? Text('Select Image')
                      : Image.file(viewModel.selectedImage),
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
  _ViewModel(
      {this.navigateToAboutUs,
      this.navigateToContactUs,
      this.navigateToImageEditor,
      this.selectedImage});
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
        selectedImage: store.state.imageEditorState.selectedImage);
  }
}
