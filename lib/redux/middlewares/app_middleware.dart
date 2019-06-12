import 'package:photo_share/redux/actions/navigation_actions.dart';
import 'package:photo_share/redux/states/app_state.dart';
import 'package:photo_share/utilities/keys.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> appMiddleware([AppState state]) {
  final navigationMiddleware = _navigatorMiddleware(state);
  return [
    TypedMiddleware<AppState, NavigateToContactUsPage>(navigationMiddleware),
    TypedMiddleware<AppState, NavigateToAboutUsPage>(navigationMiddleware),
    TypedMiddleware<AppState, NavigateToImageEditingPage>(navigationMiddleware),
  ];
}

Middleware<AppState> _navigatorMiddleware(AppState state) {
  return (Store store, action, NextDispatcher next) {
    if (action is NavigateToAboutUsPage) {
      Keys.navKey.currentState.pushNamed("/AboutUsView");
    } else if (action is NavigateToImageEditingPage) {
      Keys.navKey.currentState.pushNamed('/ImageEditingView');
    } else if (action is NavigateToContactUsPage) {
      Keys.navKey.currentState.pushNamed('/ContactUsView');
    }
  };
}
