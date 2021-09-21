import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import 'package:card_x_user/app/middlewares/auth_middleware.dart';
import 'package:card_x_user/app/modules/admin/bindings/admin_binding.dart';
import 'package:card_x_user/app/modules/admin/views/admin_view.dart';
import 'package:card_x_user/app/modules/auth/bindings/auth_binding.dart';
import 'package:card_x_user/app/modules/auth/views/auth_view.dart';
import 'package:card_x_user/app/modules/avatar/bindings/avatar_binding.dart';
import 'package:card_x_user/app/modules/avatar/views/avatar_view.dart';
import 'package:card_x_user/app/modules/card_ui/bindings/card_ui_binding.dart';
import 'package:card_x_user/app/modules/card_ui/views/card_ui_view.dart';
import 'package:card_x_user/app/modules/home/bindings/home_binding.dart';
import 'package:card_x_user/app/modules/home/views/home_view.dart';
import 'package:card_x_user/app/modules/pokemon_card_list/bindings/pokemon_card_list_binding.dart';
import 'package:card_x_user/app/modules/pokemon_card_list/views/pokemon_card_list_view.dart';
import 'package:card_x_user/app/modules/pokemon_product/bindings/pokemon_product_binding.dart';
import 'package:card_x_user/app/modules/pokemon_product/views/pokemon_product_view.dart';
import 'package:card_x_user/app/modules/pokemon_rarities/bindings/pokemon_rarities_binding.dart';
import 'package:card_x_user/app/modules/pokemon_rarities/views/pokemon_rarities_view.dart';
import 'package:card_x_user/app/modules/pokemon_select/bindings/pokemon_select_binding.dart';
import 'package:card_x_user/app/modules/pokemon_select/views/pokemon_select_view.dart';
import 'package:card_x_user/app/modules/pokemon_set/bindings/pokemon_set_binding.dart';
import 'package:card_x_user/app/modules/pokemon_set/views/pokemon_set_view.dart';
import 'package:card_x_user/app/modules/pokemon_types/bindings/pokemon_types_binding.dart';
import 'package:card_x_user/app/modules/pokemon_types/views/pokemon_types_view.dart';
import 'package:card_x_user/app/modules/profile/bindings/profile_binding.dart';
import 'package:card_x_user/app/modules/profile/views/profile_view.dart';
import 'package:card_x_user/app/modules/scan_card/bindings/scan_card_binding.dart';
import 'package:card_x_user/app/modules/scan_card/views/barcode_pre_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/document_pre_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/filter_all_page_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/menu_item_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_filtering_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_operations_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/page_widget_view.dart';
import 'package:card_x_user/app/modules/scan_card/views/scan_card_view.dart';
import 'package:card_x_user/app/modules/send_password_email/bindings/send_password_email_binding.dart';
import 'package:card_x_user/app/modules/send_password_email/views/send_password_email_view.dart';
import 'package:card_x_user/app/modules/settings/bindings/settings_binding.dart';
import 'package:card_x_user/app/modules/settings/views/settings_view.dart';
import 'package:card_x_user/app/modules/sign_in/bindings/sign_in_binding.dart';
import 'package:card_x_user/app/modules/sign_in/views/sign_in_view.dart';
import 'package:card_x_user/app/modules/sign_up/bindings/sign_up_binding.dart';
import 'package:card_x_user/app/modules/sign_up/views/sign_up_view.dart';
import 'package:card_x_user/app/modules/social_connection/bindings/social_connection_binding.dart';
import 'package:card_x_user/app/modules/social_connection/views/social_connection_view.dart';
import 'package:card_x_user/app/modules/un_known_route_page/bindings/un_known_route_page_binding.dart';
import 'package:card_x_user/app/modules/un_known_route_page/views/un_known_route_page_view.dart';
import 'package:card_x_user/app/modules/update_profile/bindings/update_profile_binding.dart';
import 'package:card_x_user/app/modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.POKEMON_CARD_LIST;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      participatesInRootNavigator: true,
      // preventDuplicates: true,
      // opaque: true,
      // maintainState: true,
      middlewares: [EnsureAuthMiddleware(), EnsureProfileMiddleware()],
      popGesture: true,
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
      // middlewares: [EnsureAuthMiddleware()],
    ),
    GetPage(
      name: _Paths.CARD_UI,
      page: () => CardUiView(),
      binding: CardUiBinding(),
      // middlewares: [EnsureAuthMiddleware()],
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
      // middlewares: [EnsureNotAuthedMiddleware()],
    ),
    GetPage(
      name: _Paths.AVATAR,
      page: () => AvatarView(),
      binding: AvatarBinding(),
      // middlewares: [EnsureAuthMiddleware()],
      popGesture: true,
    ),
    GetPage(
        name: _Paths.SCAN_CARD,
        page: () => ScanCardView(),
        binding: ScanCardBinding(),
        popGesture: true,
        arguments: Get.arguments,
        children: [
          GetPage(
            name: '/barcode-preview',
            page: () => BarcodePreView(Get.arguments),
            arguments: Get.arguments,
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
    GetPage(
      name: _Paths.ADMIN,
      page: () => AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.UN_KNOWN_ROUTE_PAGE,
      page: () => UnKnownRoutePageView(),
      binding: UnKnownRoutePageBinding(),
      // middlewares: [EnsureAuthMiddleware()],
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SEND_PASSWORD_EMAIL,
      page: () => SendPasswordEmailView(),
      binding: SendPasswordEmailBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SOCIAL_CONNECTION,
      page: () => SocialConnectionView(),
      binding: SocialConnectionBinding(),
    ),
    GetPage(
      name: _Paths.POKEMON_PRODUCT,
      page: () => PokemonProductView(),
      binding: PokemonProductBinding(),
    ),
    GetPage(
      name: _Paths.POKEMON_RARITIES,
      page: () => PokemonRaritiesView(),
      binding: PokemonRaritiesBinding(),
    ),
    GetPage(
      name: _Paths.POKEMON_SELECT,
      page: () => PokemonSelectView(),
      binding: PokemonSelectBinding(),
    ),
    GetPage(
      name: _Paths.POKEMON_SET,
      page: () => PokemonSetView(),
      binding: PokemonSetBinding(),
    ),
    GetPage(
      name: _Paths.POKEMON_TYPES,
      page: () => PokemonTypesView(),
      binding: PokemonTypesBinding(),
    ),
    GetPage(
      name: _Paths.POKEMON_CARD_LIST,
      page: () => PokemonCardListView(),
      binding: PokemonCardListBinding(),
    ),
  ];
}
