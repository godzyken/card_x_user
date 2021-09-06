import 'package:card_x_user/app/modules/admin/views/admin_view.dart';
import 'package:card_x_user/app/modules/auth/sign_in/views/sign_in_view.dart';
import 'package:card_x_user/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../user_model.dart';

class AuthController extends GetxController {
  static AuthController? get to => Get.find<AuthController>();

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  GoogleSignIn? googleSignIn;

  var isSignIn = false.obs;
  final firebaseUser = Rxn<User>();
  final fireStoreUser = Rxn<UserModel>();
  final connect = GetxFire.firestore;
  final auth = GetxFire.auth;

  final admin = false.obs;

  @override
  void onInit() {
    ever(admin, fireRoute);
    admin.value = fireStoreUser.value!.siteAdmin!;
    super.onInit();
  }

  @override
  void onReady() async {
    googleSignIn = GoogleSignIn();
    ever(isSignIn, handleAuthChanged);
    isSignIn.value = auth.currentUser != null;
    auth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });

    super.onReady();
  }

  @override
  void onClose() {
    // signOut();
    // auth.signOut();
    // passwordController.value.dispose();
    // firebaseUser.close();
    // fireStoreUser.close();
    // googleSignIn!.disconnect();
    super.onClose();
  }

  fireRoute(logged) {
    if (logged) {
      Get.off(AdminView());
    } else {
      Get.off(SignInView());
    }
  }

  ///[CRUD] on fireStore with GetXfire
  void _createUserFirestore(UserModel? userModel, User? _firebaseUser) {
    connect
        .createData(
            collection: '/users/${_firebaseUser!.uid}',
            data: userModel!.toJson())
        .then((value) => GetxFire.openDialog
            .messageSuccess("Create $userModel successfully!"));
    update();
  }

  void _searchUserFirestore(UserModel? userModel, User? _firebaseUser) {
    connect.searchData(
      collection: '/users/${_firebaseUser!.uid}',
      search: '${userModel!.id}',
      ownerUID: '/admin/${userModel.login}'
    );
    update();
  }

  void _updateUserFirestore(UserModel? userModel, User? _firebaseUser) {
    connect.updateData(
        collection: '/users/${_firebaseUser!.uid}',
        id: '${userModel!.id}',
        data: userModel.toJson());
    update();
  }

  void _removeUserFirestore(UserModel? userModel, User? _firebaseUser) {
    connect.deleteData(
        collection: '/users/${_firebaseUser!.uid}',
        id: '${userModel!.id}',
        photo: FileModel(
          url: userModel.avatarUrl,
          filename: userModel.name,
        ));
    update();
  }

  ///[Stream] user on fireStore with GetXfire
  Stream<User?> get user => GetxFire.userChanges();

  ///[Streams] the firestore user from the firestore collection
  Stream<UserModel?> streamFirestoreUser() {
    print('stream on firestore users of userModel');

    return FirebaseFirestore.instance
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  ///Get [PhotoUrl] for Profile [avatar]
  getPhotoUrl() {
    final _auth = auth.obs;
    if (_auth.value.currentUser?.photoURL != null) {
      return Image.network(
        _auth.value.currentUser!.photoURL!,
        height: 100,
        width: 100,
      );
    } else {
      return Icon(
        Icons.account_circle,
        size: 100,
        color: Colors.red,
      );
    }
  }

  void handleAuthChanged(isLoggedIn) {
    if (isLoggedIn) {
      Get.offAllNamed(Routes.HOME, arguments: auth.currentUser);

      update();
    } else {
      // Get.offAllNamed(Routes.SIGNUP);
      Get.until((route) => Get.currentRoute == '/sign-up');
    }
  }

  ///Firebase user one-time fetch
  Future<User?> get getUser async => auth.currentUser;

  Future<Object?> getFirestoreUser() async {
    if (firebaseUser.value?.uid != null) {
      return connect.getDetail(
          collection: '/users', id: '/${firebaseUser.value?.uid}');
    }

    return null;
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await auth.sendPasswordResetEmail(email: emailController.value.text);

      Get.snackbar('reset password notice title'.tr, 'reset password notice'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
      update();
    } catch (e) {
      Get.snackbar('reset password failed'.tr, 'error message'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  ///handles updating the user when updating profile
  Future<void> updateUser(BuildContext context, UserModel user, String oldEmail,
      String password) async {
    try {
      //showLoadingIndicator();
      await auth
          .signInWithEmailAndPassword(email: oldEmail, password: password)
          .then((_firebaseUser) {
        _firebaseUser.user!
            .updateEmail(user.email!)
            .then((value) => _updateUserFirestore(user, _firebaseUser.user!));
      });
      //hideLoadingIndicator();
      Get.snackbar('Update User Success Notice Title !'.tr,
          'Update User Success Notice !'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    } on PlatformException catch (error) {
      //List<String> errors = error.toString().split(',');
      // print("Error: " + errors[1]);
      Get.overlayContext!;
      print(error.code);
      String? authError;
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD':
          authError = 'Wrong Password Notice'.tr;
          break;
        default:
          authError = 'Unknown Error'.tr;
          break;
      }
      Get.snackbar('Wrong Password Notice Title !'.tr, 'auth Error !'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    }
  }

  _googleSignOut() async {
    await googleSignIn!
        .signOut()
        .then((value) => Get.until((route) => Get.currentRoute == '/sign-up'));
  }

  signOut() async {
    nameController.value.clear();
    emailController.value.clear();
    await _googleSignOut();
    return auth.signOut();
  }

  ///Method to handle user sign in using email and password
  signInWithEmailAndPassword(BuildContext context) async {
    // //showLoadingIndicator();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.value.text.trim(),
              password: passwordController.value.text.trim())
          .then((result) async {
        //create the new user object
        var _newUser = UserModel(
            login: result.user!.uid,
            email: result.user!.email,
            name: nameController.value.text,
            avatarUrl: result.user!.photoURL);
        //create the user in firestore
        _createUserFirestore(_newUser, result.user!);
        emailController.value.clear();
        passwordController.value.clear();

        update();
        //hideLoadingIndicator();
      });
    } catch (error) {
      //hideLoadingIndicator();
      Get.snackbar('Sign in error title'.tr, 'Sign in Error'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  ///User registration using email and password
  registerWithEmailAndPassword(BuildContext context) async {
    //showLoadingIndicator();
    try {
      GetxFire.createUserWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
        isSuccessDialog: true,
        onSuccess: (userCredential) {
          if (userCredential!.user != null) {
            isSignIn.value = true;
          } else {
            isSignIn.value = false;
          }
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
            name: nameController.value.text,
            avatarUrl: result.user!.photoURL);
        //create the user in firestore
        _createUserFirestore(_newUser, result.user!);
        emailController.value.clear();
        passwordController.value.clear();

        update();
        //hideLoadingIndicator();
      });
    } catch (error) {
      //hideLoadingIndicator();
      Get.snackbar('Sign up error title'.tr, 'error.message'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    }
  }

  //check if user is an admin user
  isAdmin() async {
    await getUser.then((user) async {
      var adminRef = connect.streamDetail(
          collection: '/users',
          id: '/${user!.uid}',
          collectionChild: '/admin',
          idChild: '/${user.tenantId}');

      if (user.tenantId != null) {
        admin.value = true;
      } else {
        admin.value = false;
      }
      update();
    });
  }

  ///Method to handle user sign in using [google_sign_in]
  getGoogleSignIn(BuildContext context) async {
    try {
      await GetxFire.signInWithGoogle(
        onSuccess: (userCredential) {
          final user = userCredential!.user;
          var _newUser = UserModel(
            name: user!.displayName,
            login: user.uid,
            avatarUrl: user.photoURL,
            email: user.email,
          );

          _createUserFirestore(_newUser, user);

          Get.toNamed('/home');
          Get.snackbar('Sign In', 'Sign in ${user.uid} with Google');
        },
        onError: (code, message) {
          Get.snackbar('Error', 'Failed to sign in with Google: $message');
        },
        isErrorDialog: true,
        isSuccessDialog: true,
      );
      //showLoadingIndicator();
      update();

      //hideLoadingIndicator();
    } catch (error) {
      //hideLoadingIndicator();
      Get.snackbar('Sign In Error Title !'.tr, 'Sign In Error !'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    }
  }
}
