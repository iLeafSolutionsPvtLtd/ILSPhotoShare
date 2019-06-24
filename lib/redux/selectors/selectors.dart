import 'dart:io';

import 'package:insta_capture/models/loading_status.dart';
import 'package:insta_capture/redux/states/app_state.dart';

LoadingStatus isLoadingSelector(AppState state) =>
    state.authState.loadingStatus;

bool isErrorSelector(AppState state) =>
    state.authState.loadingStatus == LoadingStatus.error;

bool isFirstNameValid(AppState state) => state.authState.isFirstNameValid;

bool isSecondNameValid(AppState state) => state.authState.isSecondNameValid;

bool isEmailValid(AppState state) => state.authState.isEmailValid;

bool isMobileNumberValid(AppState state) => state.authState.mobileNumberError;

bool isPasswordValid(AppState state) => state.authState.passwordError;

bool isLoggedIn(AppState state) => state.authState.isLoggedIn;

bool showAlert(AppState state) => state.authState.apiResponseHandler.showAlert;

File selectedImage(AppState state) => state.selectedImage;
