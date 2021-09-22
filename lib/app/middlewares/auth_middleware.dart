import 'package:card_x_user/app/modules/admin/bindings/admin_binding.dart';
import 'package:card_x_user/app/modules/auth/bindings/auth_binding.dart';
import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:card_x_user/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  static final middlewares = [
    GetMiddleware(priority: 2),
    GetMiddleware(priority: 5),
    GetMiddleware(priority: 4),
    GetMiddleware(priority: -8),
  ];
  final authServices = AuthController();

  int? get priority => 2;


  @override
  RouteSettings? redirect(String? route) {
    return authServices.isSignIn.value != false || route == Routes.HOME
        ? null
        : RouteSettings(name: Routes.AUTH);
  }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final authServices = AuthController();
    if (!authServices.isSignIn.value) {
      final newRoute = Routes.LOGIN_THEN(route.location!);
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }

  @override
  void onPageDispose() {
    super.onPageDispose();
  }

  @override
  Widget onPageBuilt(Widget? page) {
    print('bindings are ready');
    return page!;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) => page;

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    final authService = Get.find<AuthController>();
    if (authService.admin.value) {
      bindings!.add(AdminBinding());
    }
    return bindings;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return page!.copy(
      name: '/auth',
      settings: redirect('/auth'),
      middlewares: middlewares,
      binding: AuthBinding(),
      arguments: authServices.user,
      popGesture: true,
    );
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final authServices = Get.put(AuthController());

    if (authServices.isSignIn.value) {
      //NEVER navigate to auth screen, when user is already authed
      //return null;

      //OR redirect user to another screen
      return GetNavConfig.fromRoute(Routes.PROFILE);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureProfileMiddleware extends GetMiddleware {
  @override
  int? get priority => 4;

  var isProfileSet = false.obs;

  @override
  RouteSettings? redirect(String? route) {
    final authServices = AuthController();
    if (isProfileSet.value == authServices.isSignIn.isFalse) {
      return RouteSettings(name: Routes.HOME);
    }
  }


}
