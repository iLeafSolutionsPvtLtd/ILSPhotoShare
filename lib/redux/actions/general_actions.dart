import 'dart:ui';

import 'package:insta_capture/models/loading_status.dart';

class ChangeLoadingStatusAction {
  final LoadingStatus status;
  ChangeLoadingStatusAction(this.status);
}

class EmailErrorAction {
  final bool status;
  final String message;
  EmailErrorAction(this.message, this.status);
}

class PasswordErrorAction {
  final bool status;
  final String message;
  PasswordErrorAction(this.message, this.status);
}

class MobileNumberErrorAction {
  final bool status;
  final String message;
  MobileNumberErrorAction(this.message, this.status);
}

class OTPErrorAction {
  final bool status;
  final String message;
  OTPErrorAction(this.message, this.status);
}

class ChangeLoginStatusAction {
  final bool loginStatus;
  ChangeLoginStatusAction(this.loginStatus);
}

class CheckTokenAction {
  final VoidCallback hasTokenCallback;
  final VoidCallback noTokenCallback;
  CheckTokenAction({this.hasTokenCallback, this.noTokenCallback});
}

class ValidatePasswordAction {
  final String password;
  ValidatePasswordAction(this.password);
}
