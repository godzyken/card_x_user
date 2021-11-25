import 'package:card_x_user/app/modules/admin/views/admin_view.dart';
import 'package:card_x_user/app/modules/sign_in/views/sign_in_view.dart';
import 'package:card_x_user/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getxfire/getxfire.dart';

import '../user_model.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  var isSignIn = false.obs;
  var rememberme = false.obs;

  bool get authenticated => isSignIn.value;

  set authenticated(value) => isSignIn.value = value;

  final firebaseUser = Rxn<User>();
  final fireStoreUser = Rxn<UserModel>();
  final connect = GetxFire.firestore;
  final auth = GetxFire.auth;

  Map<String, String> _dataUser = {
    'email': 'isgodzy@gmail.com',
    'password': 'dattebayo',
    'name': 'Rio',
    'rememberme': 'Rio',
  };

  final admin = false.obs;

  @override
  void onInit() {
    // ever(admin, fireRoute);
    // admin.value = fireStoreUser.value!.siteAdmin!;
    super.onInit();
  }

  @override
  void onReady() async {
    ever(isSignIn, handleAuthChanged);
    isSignIn.value = GetxFire.currentUser != null;
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

  void dialogError(String? msg) {
    Get.defaultDialog(
      title: 'Hi mé ké passo!',
      middleText: msg!,
    );
  }

  void autoLogin() {
    final box = GetStorage();
    if (box.read("datauser") != null) {
      final data = box.read("dataUser") as Map<String, dynamic>;
      login(data["email"], data["password"], data["rememberme"]);
    }
  }

  void login(String? email, String? password, bool rememberme) {
    print('Echoo');
    if (email != '' && password != '') {
      print('Echoo1');
      if (GetUtils.isEmail(email!)) {
        print('Echoo2');
        if (email == _dataUser['email'] && password == _dataUser["password"]) {
          print('Echoo3');
          if (rememberme) {
            print('Echoo4');
            final box = GetStorage();
            box.write('dataUser', {
              "email": email,
              "password": password,
              "rememberme": rememberme,
            });
          } else {
            print('Echoo5');
            final box = GetStorage();
            if (box.read('dataUser') != null) {
              box.erase();
            }
          }
          isSignIn.value = true;
        } else {
          dialogError('Data user is not valid');
        }
      } else {}
    } else {}
  }

  ///[CRUD] on fireStore with GetXfire
  void _createUserFirestore(UserModel? userModel, User? _firebaseUser) {
    connect
        .createData(
            collection: '/users',
            id: '${_firebaseUser!.uid}',
            data: userModel!.toJson())
        .then((value) => GetxFire.openDialog
            .messageSuccess("Create $userModel successfully!"));
    update();
  }

  void _searchUserFirestore(UserModel? userModel, User? _firebaseUser) {
    connect.searchData(
        collection: '/users/${_firebaseUser!.uid}',
        search: '${userModel!.id}',
        ownerUID: '/admin/${userModel.login}');
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

      isSignIn.value = true;
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
      Get.snackbar('reset password failed $e'.tr, 'error message'.tr,
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
      Get.snackbar('Wrong Password Notice Title !'.tr, '$authError!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    }
  }

  Future<void> deleteUser(
      BuildContext context, UserModel userModel, User? id) async {
    try {
      var userId = userModel.id;

      if (id == userId) {
        _removeUserFirestore(userModel, id);
      } else {
        Get.snackbar('remove user from firebase failed'.tr, 'remove user'.tr,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 5),
            backgroundColor: Get.theme.snackBarTheme.backgroundColor,
            colorText: Get.theme.snackBarTheme.actionTextColor);
        update();
      }
    } catch (e) {
      Get.snackbar('remove user $e'.tr, 'error removed failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  signOut() async {
    nameController.value.clear();
    emailController.value.clear();
    return auth.signOut();
  }

  ///Method to handle user sign in using email and password
  signInWithEmailAndPassword(BuildContext context) async {
    // //showLoadingIndicator();
    try {
      await auth
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
    } on FirebaseAuthException catch (code, message) {
      //hideLoadingIndicator();
      Get.snackbar('Sign in error title: $code'.tr, '$message'.tr,
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
          name: nameController.value.text,
          avatarUrl: result.user!.photoURL,
        );
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

  ///Method to handle user register in using [GetxFire]
  getGoogleSignIn(BuildContext context) async {
    try {
      await GetxFire.signInWithGoogle(
        onSuccess: (userCredential) {
          final user = userCredential!.user;
          final box = GetStorage();
          isSignIn.value = true;

          update();
          if (rememberme.isTrue) {
            var _newUser = UserModel(
              name: user!.displayName,
              login: user.uid,
              avatarUrl: user.photoURL,
              email: user.email,
              company: user.displayName,
            );
            box.write('dataUser', {_newUser.toJson()});

            _createUserFirestore(_newUser, user);

            Get.toNamed('/home', arguments: isSignIn);
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
          Get.snackbar('Error', 'Failed to sign in with Google: $message');
        },
        isErrorDialog: true,
        isSuccessDialog: true,
      );
      //showLoadingIndicator();
      update();
      Get.offAllNamed(Routes.HOME, arguments: isSignIn.value);
      //hideLoadingIndicator();
    } catch (error) {
      //hideLoadingIndicator();
      Get.snackbar('Sign In Error Title !'.tr, '$error !'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  ///Method to login user with [GetxFire]
  googleSignIn(BuildContext context) async {
    try {
      await GetxFire.signInWithGoogle(
        onSuccess: (userCredential) {
          final user = userCredential!.user;

          Get.snackbar('Sign In', 'Sign in ${user!.uid} with Google');
          isSignIn.value = true;
          Get.toNamed('/home', arguments: isSignIn);

          update();
        },
        onError: (code, message) {
          Get.snackbar('Error', 'Failed to sign in with Google: $message');
          isSignIn.value = false;
          update();
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

/*
class AuthController extends GetxController {
  final auth = GetxFire.auth;
  final connect = GetxFire.firestore;
  final firebaseUser = Rxn<User>();
  final userModel = Rxn<UserModel>();

  var isSignIn = false.obs;
  var admin = false.obs;
  var isProfileExist = false.obs;

  Stream<User?> get user => GetxFire.userChanges();

  ///[Streams] the firestore user from the firestore collection
  Stream<QuerySnapshot<Object?>> streamFirestoreUser() {
    print('stream on firestore users of userModel');

    return connect.streamData(
      collection: 'users',
      idChild: userModel.value!.login,
      collectionChild: userModel.value!.login,
      isErrorDialog: true,
      onError: (error) => Get.snackbar('Stream database error', 'Error is : $error'),
    );
  }


  ///Method to login user with [GetxFire]
  googleSignIn() async {
    await GetxFire.signInWithGoogle(
      onSuccess: (userCredential) {
        final user = userCredential!.user;

        GetxFire.openDialog.messageSuccess('Message: Congrats',
            title: 'You are just sign in with google',
            duration: Duration(seconds: 20));

        isSignIn.value = true;
        Get.toNamed('/home', arguments: isSignIn.value);

        update();
      },
      onError: (code, message) {
        GetxFire.openDialog.messageError('Message: $message',
            title: 'Sign in with google error : $code',
            duration: Duration(seconds: 20));

        isSignIn.value = false;
        update();
      },
      isErrorDialog: true,
      isSuccessDialog: true,
    );
    //showLoadingIndicator();
  }

  createUser(String? email, String? password) async {
    await GetxFire
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then(
            (result) {
          final userModel = UserModel(
            login: result!.user!.uid,
            email: result.user!.email,
            name: result.user!.displayName,
            company: result.user!.displayName,
            avatarUrl: result.user!.photoURL,
          );
          update();
        }
    )
        .onError((error, stackTrace) => null)
  }

  signOut() async {
    user.every((element) => decontUser(element!.uid));
    return auth.signOut();
  }

  bool decontUser(String? userId) {
    if (userId == UserModel().id) {
      auth.signOut();
    } else {
      auth.authStateChanges();
    }
    return true;
  }
}
*/
