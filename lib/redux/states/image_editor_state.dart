import 'dart:io';

import 'package:meta/meta.dart';
import 'package:photo_share/models/loading_status.dart';

class ImageEditorState {
  final LoadingStatus loadingStatus;
  final File selectedImage;
  final String locationName;
  ImageEditorState(
      {@required this.loadingStatus, this.selectedImage, this.locationName});

  factory ImageEditorState.initial() {
    return new ImageEditorState(
      loadingStatus: LoadingStatus.success,
      selectedImage: null,
      locationName: "",
    );
  }

  ImageEditorState copyWith(
      {LoadingStatus loadingStatus, File selectedImage, String locationName}) {
    return new ImageEditorState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      selectedImage: selectedImage ?? this.selectedImage,
      locationName: locationName ?? this.locationName,
    );
  }
}
