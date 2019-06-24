import 'package:insta_capture/redux/states/app_state.dart';

import 'ImageEditorReducer.dart';
import 'auth_reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    authState: authReducer(state.authState, action),
    imageEditorState: imageEditorReducer(state.imageEditorState, action),
  );
}
