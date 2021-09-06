import 'package:card_x_user/app/components/ui.dart';
import 'package:card_x_user/app/modules/auth/sign_in/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SignInView extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return GetBuilder<SignInController>(
      assignId: true,
      builder: (_) {
        return Form(
          key: _formKey,
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
                    PrimaryButton(
                      labelText: 'Sign In'.tr,
                      onPressed: () => _formKey =
                          _formKey.currentState!.validate()
                              ? _.authController!
                                  .signInWithEmailAndPassword(context)
                              : Text('Something want wrong !, verify the form'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
