import 'dart:io';

import 'package:equatable/equatable.dart';

import 'auth_state.dart';
import 'home_page_state.dart';
import 'image_editor_state.dart';

class AppState extends Equatable {
  final bool isLoading;
  final AuthState authState;
  final File selectedImage;
  final HomePageState homePageState;
  final ImageEditorState imageEditorState;
  AppState(
      {this.authState,
      this.homePageState,
      this.isLoading,
      this.selectedImage,
      this.imageEditorState})
      : super([
          isLoading,
          authState,
          selectedImage,
          homePageState,
          imageEditorState
        ]);

  factory AppState.initial() => AppState(
      authState: AuthState.initial(),
      homePageState: HomePageState.initial(),
      imageEditorState: ImageEditorState.initial(),
      selectedImage: null,
      isLoading: false);

  AppState copyWith({
    AuthState authState,
    HomePageState homePageState,
    bool isLoading,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      homePageState: homePageState ?? this.homePageState,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
