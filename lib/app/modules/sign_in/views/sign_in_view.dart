import 'package:card_x_user/app/components/ui.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: Text('Log yo in'),
        ),
        body: GetBuilder<SignInController>(
          assignId: true,
          builder: (_) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        FormInputFieldWithIcon(
                          controller: _.authControl.emailController.value,
                          iconPrefix: Icons.email,
                          labelText: 'Email'.tr,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (p0) =>
                              _.authControl.emailController.value.text = p0!,
                          maxLines: 1,
                        ),
                        FormVerticalSpace(),
                        FormInputFieldWithIcon(
                          controller: _.authControl.passwordController.value,
                          iconPrefix: Icons.password,
                          labelText: 'Password'.tr,
                          obscureText: true,
                          onSaved: (p0) =>
                              _.authControl.emailController.value.text = p0!,
                          maxLines: 1,
                        ),
                        FormVerticalSpace(),
                        PrimaryButton(
                          labelText: 'Sign In'.tr,
                          onPressed: () => _formKey = _formKey.currentState!
                                  .validate()
                              ? _.authControl
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
        ));
  }
}
