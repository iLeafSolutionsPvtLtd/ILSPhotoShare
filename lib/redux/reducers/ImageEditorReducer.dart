import 'package:insta_capture/redux/actions/image_editing_actions.dart';
import 'package:insta_capture/redux/states/image_editor_state.dart';
import 'package:redux/redux.dart';

final imageEditorReducer = combineReducers<ImageEditorState>([
  TypedReducer<ImageEditorState, UpdateSelectedImage>(_updateSelectedImage),
  TypedReducer<ImageEditorState, UpdateLocationName>(_updateLocation),
]);

ImageEditorState _updateSelectedImage(
    ImageEditorState state, UpdateSelectedImage action) {
  return state.copyWith(selectedImage: action.image);
}

ImageEditorState _updateLocation(
    ImageEditorState state, UpdateLocationName action) {
  return state.copyWith(locationName: action.name);
}
