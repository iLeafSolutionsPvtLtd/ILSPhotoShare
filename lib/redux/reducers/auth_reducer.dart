import 'package:insta_capture/redux/actions/general_actions.dart';
import 'package:insta_capture/redux/states/auth_state.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, ChangeLoadingStatusAction>(
      _changeLoadingStatusAction),
  TypedReducer<AuthState, EmailErrorAction>(_emailErrorAction),
  TypedReducer<AuthState, PasswordErrorAction>(_passwordErrorAction),
  TypedReducer<AuthState, ChangeLoginStatusAction>(_changeLoginStatusAction),
  TypedReducer<AuthState, MobileNumberErrorAction>(_mobileNumberErrorAction),
//  TypedReducer<AuthState, APIResponseMessageAction>(_updateApiErrorMessage),
]);

AuthState _mobileNumberErrorAction(
    AuthState state, MobileNumberErrorAction action) {
  return state.copyWith(mobileNumberError: action.status);
}

AuthState _emailErrorAction(AuthState state, EmailErrorAction action) {
  return state.copyWith(
      emailError: action.status, emailErrorMessage: action.message);
}

AuthState _passwordErrorAction(AuthState state, PasswordErrorAction action) {
  return state.copyWith(
      passwordError: action.status, passwordErrorMessage: action.message);
}

AuthState _changeLoadingStatusAction(
    AuthState state, ChangeLoadingStatusAction action) {
  return state.copyWith(loadingStatus: action.status);
}

AuthState _changeLoginStatusAction(
    AuthState state, ChangeLoginStatusAction action) {
  return state.copyWith(isLoggedIn: action.loginStatus);
}
