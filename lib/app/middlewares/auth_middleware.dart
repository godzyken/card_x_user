import 'package:card_x_user/app/modules/admin/bindings/admin_binding.dart';
import 'package:card_x_user/app/modules/auth/bindings/auth_binding.dart';
import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:card_x_user/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import '../modules/auth/controllers/auth_controller.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  static final middlewares = [
    GetMiddleware(priority: 2),
    GetMiddleware(priority: 5),
    GetMiddleware(priority: 4),
    GetMiddleware(priority: -8),
  ];

  final authServices = AuthController();

  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    if (authServices.isSignIn.isFalse) {
      return RouteSettings(name: Routes.SIGN_IN);
    } else {
      return RouteSettings(name: Routes.HOME);
    }
  }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (!authServices.isSignIn.isTrue) {
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
    return super.onPageBuilt(page!);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) =>
      super.onPageBuildStart(page!);

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    if (authServices.admin.isTrue) {
      bindings!.add(AdminBinding());
    }
    return super.onBindingsStart(bindings!);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return page!.copy(
      name: '/home',
      title: 'Welcome ${authServices.firebaseUser.value?.displayName} ',
      settings: redirect('/auth'),
      middlewares: middlewares,
      binding: AuthBinding(),
      arguments: authServices.user,
      popGesture: true,
    );
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  final authServices = AuthController();

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (authServices.isSignIn.isTrue) {
      //NEVER navigate to auth screen, when user is already authed
      //return null;

      //OR redirect user to another screen
      return GetNavConfig.fromRoute(Routes.PROFILE);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureProfileMiddleware extends GetMiddleware {
  final authServices = AuthController();

  @override
  int? get priority => 4;

  var isProfileSet = false.obs;

  @override
  RouteSettings? redirect(String? route) {
    if (isProfileSet.value == authServices.isSignIn.isFalse) {
      return RouteSettings(name: Routes.SIGNUP);
    }
  }
}
