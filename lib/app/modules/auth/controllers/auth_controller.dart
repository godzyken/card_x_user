import 'package:card_x_user/app/components/ui.dart';
import 'package:card_x_user/app/modules/auth/sign_up/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../user_model.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final _googleSignIn = GoogleSignIn(scopes: ['email']);
  final firebaseUser = Rxn<User>();
  final fireStoreUser = Rxn<UserModel>();
  final connect = GetxFire.firestore;
  final auth = GetxFire.auth;

  final admin = false.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = await getUser;
    firebaseUser.bindStream(user);
    super.onReady();
  }

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }

  void increment() => count.value++;

  ///[CRUD] on fireStore with GetXfire
  void _createUserFirestore(UserModel? userModel, User? _firebaseUser) {
    connect.createData(
        collection: '/users/${_firebaseUser!.uid}', data: userModel!.toJson());
    update();
  }

  void _searchUserFirestore(UserModel? userModel, User? _firebaseUser) {
    connect.searchData(
      collection: '/users/${_firebaseUser!.uid}',
      search: '${userModel!.id}',
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

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser?.uid != null) {
      fireStoreUser.bindStream(streamFirestoreUser());
      await isAdmin();
      update();
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
      showLoadingIndicator();
      await auth
          .signInWithEmailAndPassword(email: oldEmail, password: password)
          .then((_firebaseUser) {
        _firebaseUser.user!
            .updateEmail(user.email!)
            .then((value) => _updateUserFirestore(user, _firebaseUser.user!));
      });
      hideLoadingIndicator();
      Get.snackbar('Update User Success Notice Title !'.tr,
          'Update User Success Notice !'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    } on PlatformException catch (error) {
      //List<String> errors = error.toString().split(',');
      // print("Error: " + errors[1]);
      hideLoadingIndicator();
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

  Future<void> _googleSignOut() async {
    await _googleSignIn.signOut().then((value) => Get.offAll(SignUpView()));
  }

  Future<void> signOut() async {
    nameController.value.clear();
    emailController.value.clear();
    _googleSignOut();
    return auth.signOut();
  }

  ///Method to handle user sign in using email and password
  signInWithEmailAndPassword(BuildContext context) async {
    // showLoadingIndicator();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.value.text.trim(),
          password: passwordController.value.text.trim());
      emailController.value.clear();
      passwordController.value.clear();

      update();
      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('Sign in error title'.tr, 'Sign in Error'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    }
  }

  ///User registration using email and password
  registerWithEmailAndPassword(BuildContext context) async {
    showLoadingIndicator();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text)
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
        hideLoadingIndicator();
      });
    } catch (error) {
      hideLoadingIndicator();
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
      if (adminRef.isBroadcast) {
        admin.value = true;
      } else {
        admin.value = false;
      }
      update();
    });
  }

  ///Method to handle user sign in using [google_sign_in]
  googleSignIn(BuildContext context) async {
    showLoadingIndicator();

    try {
      final GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await auth
          .signInWithCredential(credential)
          .then((value) => Get.toNamed('/home'));

      update();

      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('Sign In Error Title !'.tr, 'Sign In Error !'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    }
  }
}
