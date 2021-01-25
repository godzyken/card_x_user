import 'package:card_x_user/ui/auth/auth.dart';
import 'package:card_x_user/ui/pages/card/widgets/card_widget.dart';
import 'package:card_x_user/ui/ui.dart';
import 'package:card_x_user/ui/pages/pages_ui.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:card_x_user/ui/pages/conference/conference.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/sign-in', page: () => SignInUI()),
    GetPage(name: '/sign-up', page: () => SignUpUI()),
    GetPage(name: '/home', page: () => HomeUI()),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
    GetPage(name: '/card-profile/:id/me', page: () => CardProfileUser()),
    GetPage(name: '/create-a-card/:id/edit', page: () => CreateACardUi()),
    GetPage(name: '/explorer', page: () => MyExplorerUi()),
    GetPage(name: '/view-card-user', page: () => CardDetailsView()),
    GetPage(name: '/room', page: () => RoomPage()),
    GetPage(name: '/call', page: () => CallPage()),
  ];
}