import 'package:flutter/foundation.dart';
import 'package:photo_share/models/api_response_handler.dart';
import 'package:photo_share/models/loading_status.dart';

class AuthState {
  final LoadingStatus loadingStatus;
  final String password;
  final bool passwordError;
  final String retypePassword;
  final String retypePasswordError;
  final String email;
  final bool isEmailValid;
  final bool mobileNumberError;
  final bool isFirstNameValid;
  final bool isSecondNameValid;
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final String token;
  final bool isLoggedIn;
  final APIResponseHandlerModel apiResponseHandler;

  AuthState({
    @required this.loadingStatus,
    @required this.password,
    @required this.passwordError,
    @required this.retypePassword,
    @required this.retypePasswordError,
    @required this.email,
    @required this.isEmailValid,
    @required this.emailErrorMessage,
    @required this.passwordErrorMessage,
    @required this.token,
    @required this.isLoggedIn,
    @required this.apiResponseHandler,
    @required this.mobileNumberError,
    @required this.isFirstNameValid,
    @required this.isSecondNameValid,
  });

  factory AuthState.initial() {
    return new AuthState(
        loadingStatus: LoadingStatus.success,
        password: "",
        passwordError: true,
        retypePassword: "",
        retypePasswordError: "",
        email: "",
        isEmailValid: true,
        emailErrorMessage: "",
        passwordErrorMessage: "",
        token: "",
        isLoggedIn: false,
        mobileNumberError: true,
        apiResponseHandler: APIResponseHandlerModel("", false, 0),
        isFirstNameValid: true,
        isSecondNameValid: true);
  }

  AuthState copyWith({
    LoadingStatus loadingStatus,
    String password,
    bool passwordError,
    String retypePassword,
    String retypePasswordError,
    String email,
    bool emailError,
    bool mobileNumberError,
    String emailErrorMessage,
    String passwordErrorMessage,
    String token,
    bool isLoggedIn,
    bool showAlert,
    String apiErrorMessage,
    APIResponseHandlerModel apiResponseHandler,
    bool isFirstNameValid,
    bool isSecondNameValid,
  }) {
    return new AuthState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      retypePassword: retypePassword ?? this.retypePassword,
      retypePasswordError: retypePasswordError ?? this.retypePasswordError,
      email: email ?? this.email,
      isEmailValid: emailError ?? this.isEmailValid,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      token: token ?? this.token,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      apiResponseHandler: apiResponseHandler ?? this.apiResponseHandler,
      mobileNumberError: mobileNumberError ?? this.mobileNumberError,
      isSecondNameValid: isSecondNameValid ?? this.isSecondNameValid,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
    );
  }
}
