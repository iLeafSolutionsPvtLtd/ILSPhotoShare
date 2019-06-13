import 'package:photo_share/redux/actions/image_editing_actions.dart';
import 'package:photo_share/redux/states/image_editor_state.dart';
import 'package:redux/redux.dart';

final imageEditorReducer = combineReducers<ImageEditorState>([
  TypedReducer<ImageEditorState, UpdateSelectedImage>(_updateSelectedImage),
]);

ImageEditorState _updateSelectedImage(
    ImageEditorState state, UpdateSelectedImage action) {
  return state.copyWith(selectedImage: action.image);
}
