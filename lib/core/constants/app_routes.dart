import 'package:card_x_user/ui/auth/auth.dart';
import 'package:card_x_user/ui/pages/favories/favories.dart';
import 'package:card_x_user/ui/pages/locations/locations.dart';
import 'package:card_x_user/ui/pages/tableau/tableau_ui.dart';
import 'package:card_x_user/ui/ui.dart';
import 'package:card_x_user/ui/pages/pages_ui.dart';
import 'package:card_x_user/ui/pages/card/card_ui.dart';
import 'package:card_x_user/ui/pages/conference/conference.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => HomeUI()),
    GetPage(name: '/sign-in', page: () => SignInUI()),
    GetPage(name: '/sign-up', page: () => SignUpUI()),
    GetPage(name: '/home', page: () => HomeUI()),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
    GetPage(name: '/card-profile/:id/me', page: () => CardProfileUser()),
    GetPage(name: '/create-a-card/:id/edit', page: () => CreateACardUi()),
    GetPage(name: '/explorer', page: () => MyExplorerUi()),
    GetPage(name: '/card-details-view/me/:id', page: () => CardDetailsView()),
    GetPage(name: '/card-user-view/me/:id', page: () => UserCard()),
    GetPage(name: '/room', page: () => RoomPage()),
    GetPage(name: '/call', page: () => CallPage()),
    GetPage(name: '/camera', page: () => TestAr()),
    GetPage(name: '/contact', page: () => FavoriesList()),
    GetPage(name: '/maps', page: () => AddressTarget()),
    GetPage(name: '/edit-table', page: () => EditTable()),
    GetPage(name: '/ar-core-view', page: () => ArCoreView()),
    GetPage(name: '/ar-core-view/test', page: () => ArCoreTest()),
  ];
}