import 'package:card_x_user/app/modules/admin/bindings/admin_binding.dart';
import 'package:card_x_user/app/modules/auth/bindings/auth_binding.dart';
import 'package:card_x_user/app/modules/auth/services/auth_services.dart';
import 'package:card_x_user/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  static final middlewares = [
    GetMiddleware(priority: 2),
    GetMiddleware(priority: 5),
    GetMiddleware(priority: 4),
    GetMiddleware(priority: -8),
  ];

  @override
  RouteSettings? redirect(String? route) {
    final authService = AuthServices();
    return authService.isLoggedInValue ? null : RouteSettings(name: '/sign-up');
  }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final authServices = AuthServices();
    if (!authServices.isLoggedInValue) {
      final newRoute = Routes.LOGIN_THEN(route.location!);
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }

  @override
  void onPageDispose() {}

  @override
  Widget onPageBuilt(Widget? page) {
    print('bindings are ready');
    return page!;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    print('bindings are ready');
    return page;
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    final authService = Get.find<AuthServices>();
    if (authService.isAdminValue) {
      bindings!.add(AdminBinding());
    }
    return bindings;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    final authServices = AuthServices();

    return page!.copy(
      name: '/home',
      settings: redirect('/auth'),
      middlewares: middlewares,
      binding: AuthBinding(),
      arguments: '${authServices.user}',
      popGesture: true,
    );
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final authServices = Get.put(AuthServices());

    if (authServices.isLoggedInValue) {
      //NEVER navigate to auth screen, when user is already authed
      return null;

      //OR redirect user to another screen
      //return GetNavConfig.fromRoute(Routes.PROFILE);
    }
    return await super.redirectDelegate(route);
  }
}
