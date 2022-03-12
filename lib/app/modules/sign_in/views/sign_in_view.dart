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
                          controller: _.emailC,
                          iconPrefix: Icons.email,
                          labelText: 'Email'.tr,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (p0) => _
                              .authController.emailController.value.text = p0!,
                          maxLines: 1,
                        ),
                        FormVerticalSpace(),
                        FormInputFieldWithIcon(
                          controller: _.passC,
                          iconPrefix: Icons.password,
                          labelText: 'Password'.tr,
                          obscureText: true,
                          onSaved: (p0) => _
                              .authController.emailController.value.text = p0!,
                          maxLines: 1,
                        ),
                        FormVerticalSpace(),
                        Obx(() {
                          return CheckboxListTile(
                            value: _.authController.rememberme.value,
                            onChanged: (value) =>
                                _.authController.rememberme.toggle(),
                            title: Text('Remember me'),
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        }),
                        FormVerticalSpace(),
                        PrimaryButton(
                          labelText: 'Sign In'.tr,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _.authController.login(
                                  _.emailC.text,
                                  _.passC.text,
                                  _.authController.rememberme.value);
                              _.authController.signInWithEmailAndPassword(context);
                            } else {
                              Text('Something want wrong !, verify the form');
                            }
                          },
                        ),
                        FormVerticalSpace(),
                        FormVerticalSpace(),
                        Text('Sign in with social connection: '),
                        FormVerticalSpace(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Gesture detector for the Google icon
                                GestureDetector(
                                    onTap: () {
                                      // Call the a method to sign in with Google
                                      _.signInWithGoogle(context);
                                    },
                                    child: Image(
                                        width: 55,
                                        image: AssetImage(
                                            'assets/img/google_logo.png'))),
                              ],
                            ),
                          ],
                        ),
                        Text("Haven't got an Account ?"),
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/sign-up');
                          },
                          child: Text("Create one, push here"),
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
