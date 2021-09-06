import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';


class HomeController extends GetxController {
  final authController = AuthController();

  Rxn<User>? _user;

  User? get user => _user!.value;

  @override
  void onInit() {
    _user = authController.firebaseUser;
    super.onInit();
  }

  @override
  void onReady() async {
    _user = Rxn<User>(authController.auth.currentUser);
    _user!.bindStream(authController.auth.authStateChanges());

    super.onReady();
  }

  @override
  void onClose() {}

}
