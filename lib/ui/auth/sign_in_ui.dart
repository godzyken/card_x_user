import 'package:card_x_user/core/controllers/controllers.dart';
import 'package:card_x_user/localizations.dart';
import 'package:card_x_user/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';

class SignInUI extends StatelessWidget {
  final AuthController? authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Scaffold(
      body: buildForm(labels, context),
    );
  }

  Form buildForm(AppLocalizations_Labels? labels, BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LogoGraphicHeader(),
                SizedBox(height: 48.0),
                FormInputFieldWithIcon(
                  controller: authController!.emailController.value,
                  iconPrefix: Icons.email,
                  labelText: labels?.auth?.emailFormField,
                  // validator: helpers.Validator(labels).email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  authController!.emailController.value.text = value!,
                ),
                FormVerticalSpace(),
                FormInputFieldWithIcon(
                  controller: authController!.passwordController.value,
                  iconPrefix: Icons.lock,
                  labelText: labels?.auth?.passwordFormField,
                  // validator: helpers.Validator(labels).password,
                  obscureText: true,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  authController!.passwordController.value.text = value!,
                  maxLines: 1,
                ),
                FormVerticalSpace(),
                PrimaryButton(
                    labelText: labels?.auth?.signInButton,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        authController!.signInWithEmailAndPassword(context);
                      }
                    }),
                FormVerticalSpace(),
                GoogleSignInButton(
                  labelText: labels?.auth?.googleSignInButton,
                  onPressed: () async {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    authController!.googleSignIn(context);
                  },
                ),
                FormVerticalSpace(),
                LabelButton(
                  labelText: labels?.auth?.resetPasswordLabelButton,
                  onPressed: () => Get.toNamed('/reset-password'),
                ),
                LabelButton(
                  labelText: labels?.auth?.signUpLabelButton,
                  onPressed: () => Get.toNamed('/sign-up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
