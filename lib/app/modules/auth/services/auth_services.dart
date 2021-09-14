import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class AuthServices extends GetxService {
  static AuthServices? get to => Get.find();

  final AuthController? authController = Get.find();

  Future<AuthServices> init() async {
    print('$runtimeType delays 2 sec');
    await 2.delay();
    print('$runtimeType ready!');
    return this;
  }

 get user => authController!.user;

  final isLoggedIn = false.obs;

  bool get isLoggedInValue => isLoggedIn.value = GetxFire.userChanges().isBroadcast;

  bool? get isAdmin => authController!.admin.isTrue;

  bool get isAdminValue => isAdmin.reactive.value!;

  bool? adminStatus() {
    if (user!.isAnonymous &&
        user!.emailVerified == false &&
        authController!.fireStoreUser.value!.siteAdmin! == false) {
      return isAdminValue.reactive.value = false;
    } else if (user!.isAnonymous == false &&
        authController!.fireStoreUser.value!.siteAdmin! == true &&
        authController!.firebaseUser.value!.emailVerified) {
      return isAdminValue.reactive.value == true;
    }

    return isAdminValue.reactive.value;
  }

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
  }

  @override
  void $configureLifeCycle() {}

  /*@override
  bool get isClosed {
    super.isClosed;
  }

  @override
  bool get initialized {}*/
}
