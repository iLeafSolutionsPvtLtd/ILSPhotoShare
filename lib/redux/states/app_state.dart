import 'dart:io';

import 'package:equatable/equatable.dart';

import 'auth_state.dart';
import 'home_page_state.dart';

class AppState extends Equatable {
  final bool isLoading;
  final AuthState authState;
  final File selectedImage;
  final HomePageState homePageState;
  AppState(
      {this.authState, this.homePageState, this.isLoading, this.selectedImage})
      : super([isLoading, authState, selectedImage, homePageState]);

  factory AppState.initial() => AppState(
      authState: AuthState.initial(),
      homePageState: HomePageState.initial(),
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

//  @override
//  bool operator ==(Object other) =>
//      identical(this, other) ||
//      other is AppState &&
//          runtimeType == other.runtimeType &&
//          authState == other.authState &&
//          homePageState == other.homePageState &&
//          isLoading == other.isLoading;
//
//  @override
//  int get hashCode => authState.hashCode ^ homePageState.hashCode;
//  @override
//  String toString() {
//    return '';
//  }
}
