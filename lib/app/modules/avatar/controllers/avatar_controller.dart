import 'package:card_x_user/app/modules/auth/user_model.dart';
import 'package:get/get.dart';

class AvatarController extends GetxController {
  //TODO: Implement AvatarController

  final user = UserModel().obs;

  get photo => user.value.avatarUrl;

  final _imageLogo = 'assets/img/default.png'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
