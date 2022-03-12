import 'package:card_x_user/app/modules/auth/controllers/auth_controller.dart';
import 'package:card_x_user/app/modules/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getxfire/getxfire.dart';

class SignUpController extends GetxController {
  final auth = AuthController().obs;

  final name = TextEditingController().obs;
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;

  var isReg = false.obs;
  var rememberMe = false.obs;

  User? get user => auth.value.firebaseUser.value;



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

  ///User registration using email and password
  registerWithEmailAndPassword() async {
    //showLoadingIndicator();

    await GetxFire.createUserWithEmailAndPassword(
      email: email.value.text,
      password: password.value.text,
      isSuccessDialog: true,
      onSuccess: (userCredential) {
        if (userCredential!.user != null) {
          isReg.value = true;
        } else {
          isReg.value = false;
        }
        update();
      },
      onError: (code, message) {
        Get.snackbar('Error registration',
            'Failed to sign with Email & Password\n$message');
      },
      isErrorDialog: true,
    ).then((result) async {
      //create the new user object
      var _newUser = UserModel(
        login: result!.user!.uid,
        email: result.user!.email,
        name: name.value.text,
        avatarUrl: result.user!.photoURL,
      );

      print('New User: $_newUser');

      name.value.clear();
      email.value.clear();
      password.value.clear();

      update();
      //hideLoadingIndicator();
    });

  }

  ///Method to handle user register in using [GetxFire]
  googleSignUp() async {
    await GetxFire.signInWithGoogle(
      onSuccess: (userCredential) {
        final user = userCredential!.user;
        final box = GetStorage();
        isReg.value = true;
        auth.value.isSignIn.value = true;

        update();
        if (rememberMe.isTrue) {
          var _newUser = UserModel(
            name: user!.displayName,
            login: user.uid,
            avatarUrl: user.photoURL,
            email: user.email,
            company: user.displayName,
          );
          box.write('dataUser', {_newUser.toJson()});

          // _createUserFirestore(_newUser, user);
          


          Get.toNamed('/home', arguments: _newUser.id);
          Get.snackbar('Sign In', 'Sign in ${user.uid} with Google');

        } else {
          final box = GetStorage();
          if (box.read('dataUser') != null) {
            box.erase();
          }
        }
      },
      onError: (code, message) {
        final box = GetStorage();
        if (box.read('dataUser') != null) {
          box.erase();
        }
        Get.snackbar('Error: $message', 'Failed to sign in with Google: $message');
      },
      isErrorDialog: true,
      isSuccessDialog: true,
    );
  }
}