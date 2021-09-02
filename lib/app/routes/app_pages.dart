import 'package:card_x_user/app/modules/scan_card/views/barcode_pre_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/document_pre_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/filter_all_page_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/menu_item_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_filtering_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_operations_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_widget_view.dart';
import 'package:get/get.dart';

import 'package:card_x_user/app/modules/auth/bindings/auth_binding.dart';
import 'package:card_x_user/app/modules/auth/reset_password/views/reset_password_view.dart';
import 'package:card_x_user/app/modules/auth/sign_in/views/sign_in_view.dart';
import 'package:card_x_user/app/modules/auth/sign_up/views/sign_up_view.dart';
import 'package:card_x_user/app/modules/auth/update_profile/views/update_profile_view.dart';
import 'package:card_x_user/app/modules/auth/views/auth_view.dart';
import 'package:card_x_user/app/modules/avatar/bindings/avatar_binding.dart';
import 'package:card_x_user/app/modules/avatar/views/avatar_view.dart';
import 'package:card_x_user/app/modules/card_ui/bindings/card_ui_binding.dart';
import 'package:card_x_user/app/modules/card_ui/views/card_ui_view.dart';
import 'package:card_x_user/app/modules/home/bindings/home_binding.dart';
import 'package:card_x_user/app/modules/home/views/home_view.dart';
import 'package:card_x_user/app/modules/scan_card/bindings/scan_card_binding.dart';
import 'package:card_x_user/app/modules/scan_card/views/scan_card_view.dart';
import 'package:card_x_user/app/modules/settings/bindings/settings_binding.dart';
import 'package:card_x_user/app/modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SCAN_CARD;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        arguments: Get.arguments,
        bindings: [
          AuthBinding(),
          SettingsBinding(),
          CardUiBinding(),
          ScanCardBinding(),
        ],
        children: [
          GetPage(name: '/scan-session', page: () => ScanCardView()),
          GetPage(name: '/card-ui', page: () => CardUiView()),
        ],
        popGesture: true),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CARD_UI,
      page: () => CardUiView(),
      binding: CardUiBinding(),
    ),
    GetPage(
        name: _Paths.AUTH,
        page: () => AuthView(),
        binding: AuthBinding(),
        children: [
          GetPage(name: _Paths.SIGNIN, page: () => SignInView()),
          GetPage(name: _Paths.SIGNUP, page: () => SignUpView()),
          GetPage(name: _Paths.UPDATEPROFILE, page: () => UpdateProfileView()),
          GetPage(name: _Paths.RSTPSWD, page: () => ResetPasswordView()),
        ]),
    GetPage(
      name: _Paths.AVATAR,
      page: () => AvatarView(),
      binding: AvatarBinding(),
    ),
    GetPage(
        name: _Paths.SCAN_CARD,
        page: () => ScanCardView(),
        binding: ScanCardBinding(),
        popGesture: true,
        arguments: Get.arguments,
        children: [
          GetPage(
            name: '/barecode-preview',
            page: () => BarcodePreView(Get.arguments),
            popGesture: true,
          ),
          GetPage(
            name: '/document-preview',
            page: () => DocumentPreView(),
            arguments: Get.arguments,
            popGesture: true,
          ),
          GetPage(
            name: '/filter-all-page',
            page: () => FilterAllPageView(Get.arguments),
            arguments: Get.arguments,
            popGesture: true,
          ),
          GetPage(
            name: '/filter-preview-widget',
            page: () => FilterAllPreviewPageView(Get.arguments),
            arguments: Get.arguments,
            popGesture: true,
          ),
          GetPage(
            name: '/menu-item',
            page: () => MenuItemView(),
            arguments: Get.arguments,
            popGesture: true,
          ),
          GetPage(
            name: '/page-filtering',
            page: () => PageFilteringView(Get.arguments),
            arguments: Get.arguments,
            popGesture: true,
          ),
          GetPage(
            name: '/page-operations',
            page: () => PageOperationsView(Get.arguments),
            arguments: Get.arguments,
            popGesture: true,
          ),
          GetPage(
            name: '/page',
            page: () => PageWidgetView(Get.arguments),
            arguments: Get.arguments,
            popGesture: true,
          ),
        ]),
  ];
}
