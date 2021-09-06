part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const SETTINGS = _Paths.SETTINGS;
  static const CARD_UI = _Paths.CARD_UI;

  static const AUTH = _Paths.AUTH;
  static String AUTH_ID(String userId) => '$AUTH/$userId';

  static const SIGNIN = _Paths.SIGNIN;
  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$SIGNIN?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  static const SIGNUP = _Paths.SIGNUP;
  static const UPDATEPROFILE = _Paths.UPDATEPROFILE;
  static const RSTPSWD = _Paths.RSTPSWD;
  static const AVATAR = _Paths.AVATAR;
  static const SCAN_CARD = _Paths.SCAN_CARD;
  static const ADMIN = _Paths.ADMIN;
  static const UN_KNOWN_ROUTE_PAGE = _Paths.UN_KNOWN_ROUTE_PAGE;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const SIGN_UP = _Paths.SIGN_UP;
  static const SEND_PASSWORD_EMAIL = _Paths.SEND_PASSWORD_EMAIL;
  static const UPDATE_PROFILE = _Paths.UPDATE_PROFILE;
  static const PROFILE = _Paths.PROFILE;
  static const SOCIAL_CONNECTION = _Paths.SOCIAL_CONNECTION;
}

abstract class _Paths {
  static const HOME = '/home';
  static const SETTINGS = '/settings';
  static const CARD_UI = '/card-ui';
  static const AUTH = '/auth';
  static const SIGNIN = '/sign-in';
  static const SIGNUP = '/sign-up';
  static const UPDATEPROFILE = '/update-profile';
  static const RSTPSWD = '/reset-password';
  static const AVATAR = '/avatar';
  static const SCAN_CARD = '/scan-card';
  static const ADMIN = '/admin';
  static const UN_KNOWN_ROUTE_PAGE = '/un-known-route-page';
  static const SIGN_IN = '/sign-in';
  static const SIGN_UP = '/sign-up';
  static const SEND_PASSWORD_EMAIL = '/send-password-email';
  static const UPDATE_PROFILE = '/update-profile';
  static const PROFILE = '/profile';
  static const SOCIAL_CONNECTION = '/social-connection';
}
