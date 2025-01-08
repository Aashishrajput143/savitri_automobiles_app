class AppStrings {
  static final AppStrings _appStrings = AppStrings._internal();
  factory AppStrings() {
    return _appStrings;
  }
  AppStrings._internal();

  String get email => 'Email';

  String get emailHint => 'john12doe@gmail.com';
  String get alert => 'Alert';
  String get yourAuthExpired =>
      'Your authentication has expired please login again';
  String get weUnable =>
      'We\'re unable to process your request.\nPlease try again.';
  String get retry => 'Retry';
  String get weUnableCheckData => 'No Internet Connection...';
  String get login => 'Login';
  String get ok => 'Ok';
  String get getOTP => 'GET OTP';
  String get hintPhone => 'Enter phone number';

  String get password => 'Password';
  String get username => 'Username';
  String get letsSignIn => 'Lets sign you in';

  String get or => 'Or';

  String get reSend => 'Resend';
  String get reSendCode => 'Resend OTP in';
  String get forget => 'Forget Password';
}

AppStrings appStrings = AppStrings();
