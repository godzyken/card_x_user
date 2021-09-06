import 'package:card_x_user/app/components/ui.dart';
import 'package:card_x_user/app/modules/auth/services/auth_services.dart';
import 'package:card_x_user/app/modules/auth/sign_up/controllers/sign_up_controller.dart';
import 'package:card_x_user/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    var _foKey = GlobalKey<FormState>();
    return GetBuilder<SignUpController>(
        assignId: true,
        builder: (_) {
          return Form(
            key: _foKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormInputFieldWithIcon(
                        controller: _.authController!.emailController.value,
                        iconPrefix: Icons.email,
                        labelText: 'Email'.tr,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (p0) =>
                            _.authController!.emailController.value.text = p0!,
                        maxLines: 1,
                      ),
                      FormVerticalSpace(),
                      FormInputFieldWithIcon(
                        controller: _.authController!.passwordController.value,
                        iconPrefix: Icons.password,
                        labelText: 'Password'.tr,
                        obscureText: true,
                        onSaved: (p0) =>
                            _.authController!.emailController.value.text = p0!,
                        maxLines: 1,
                      ),
                      FormVerticalSpace(),
                      Obx(
                        () {
                          final isLoggedIn = AuthServices.to!.isLoggedInValue;
                          return Text(
                            'You are currently:'
                            ' ${isLoggedIn ? "Logged In" : "Not Logged In"}'
                            "\nIt's impossible to enter this "
                            "route when you are logged in!",
                          );
                        },
                      ),
                      FormVerticalSpace(),
                      PrimaryButton(
                        labelText: 'Sign In'.tr,
                        onPressed: () {
                          _foKey = _foKey.currentState!.validate()
                              ? _.authController!
                                  .registerWithEmailAndPassword(context)
                              : Text('Something want wrong !, verify the form');
                          AuthServices.to!.login();
                          final thenTo = Get.rootDelegate.currentConfiguration!
                              .currentPage!.parameters?['then'];
                          Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
