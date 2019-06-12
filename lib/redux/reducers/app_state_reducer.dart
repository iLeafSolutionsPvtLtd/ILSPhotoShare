import 'package:photo_share/redux/states/app_state.dart';

import 'auth_reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    authState: authReducer(state.authState, action),
  );
}
