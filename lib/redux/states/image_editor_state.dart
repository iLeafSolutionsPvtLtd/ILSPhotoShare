import 'dart:io';

import 'package:meta/meta.dart';
import 'package:photo_share/models/loading_status.dart';

class ImageEditorState {
  final LoadingStatus loadingStatus;
  final File selectedImage;
  ImageEditorState({@required this.loadingStatus, this.selectedImage});

  factory ImageEditorState.initial() {
    return new ImageEditorState(
      loadingStatus: LoadingStatus.success,
      selectedImage: null,
    );
  }

  ImageEditorState copyWith({LoadingStatus loadingStatus, File selectedImage}) {
    return new ImageEditorState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}
