import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/auth/authentication_service.dart';
import '../data/auth/authentication_state.dart';
import '../data/auth/firebase_auth_provider.dart';
import '../data/storage/storage_service.dart';
import '../exceptions/auth_exceptions.dart';
import '../models/user_data/user_login_model.dart';
import '../models/user_data/user_register_model.dart';
import '../routes/app_pages.dart';
import '../ui/shared/dialog_helper.dart';
import 'app_auth_service.dart';

class AppAuthenticationService extends GetxService {
  final AuthenticationService _authenticationService =
  AuthenticationService(FirebaseAuthProvider());
  final _authenticationStateStream = const AuthenticationState().obs;
  final _storage = StorageService();
  final _localAuth = AppAuthService();

  var isEnabled = false.obs;

  AuthenticationState get state => _authenticationStateStream.value;

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  Future<AppAuthenticationService> init() async {
    print('$runtimeType delays 2 sec');
    await 2.delay();
    print('$runtimeType ready!');
    return this;
  }

  @override
  void onInit() async {
    _getAuthenticatedUser();

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    initAuth();
    _optionScreens();
  }

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
      //print("...user id ${user?.uid}");

      if (user == null) {
        _authenticationStateStream.value = UnAuthenticated();
      } else {
        _authenticationStateStream.value = Authenticated(user: user);
      }
    });
  }

  _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = _authenticationService.getCurrentUser;

    if (user == null) {
      // print("::::::::CALLING USER UNVAILABBLE");
      _authenticationStateStream.value = UnAuthenticated();
      storeIdToken("");
    } else {
      _authenticationStateStream.value = Authenticated(user: user);
      final String? token = await user.getIdToken();
      // print("::::::::SETTING TOKEN:::::");
      await _storage.create("token", token);
    }
  }

  refreshToken() async {
    // print("::::::::REFRESH TOKEN:::::");
    final String? token =
    await _authenticationService.getCurrentUser?.getIdToken(true);
    await _storage.create("token", token);
  }

  getAuthenticationState() {
    return _authenticationStateStream.value;
  }

  _optionScreens() async {
    if (state is UnAuthenticated) {
      // Get.offAllNamed(Routes.WELCOME);
      Get.offAllNamed(AppRoutes.LOGIN);
    } else {
      if (isEnabled.value) {
        localAuth();
        //_localAuth.authenticate();
      } else {
        Get.offAllNamed(AppRoutes.HOME);
      }
    }
  }

  storeIdToken(String idToken) async {
    await _storage.create("token", idToken);
  }

  localAuth() async {
    Get.toNamed(AppRoutes.LOCALAUTH);
    //_localAuth.authenticate();
  }

  User? getCurrentUser() {
    return _authenticationService.getCurrentUser!;
  }

  Future<void> loginWithEmail(UserLoginModel login) async {
    try {
      await _authenticationService.loginInWithEmailAndPassword(login: login);
      _getAuthenticatedUser();
      _optionScreens();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      final errorMessage = UserAuthFailureException.code(e.code);
      DialogHelper.showErrorDialog(description: errorMessage.message);
    } on SocketException {
      DialogHelper.showErrorDialog(description: "No internet connection.");
    }
  }

  Future<void> registerWithEmail(UserRegisterModel register) async {
    try {
      await _authenticationService.registerWithEmailAndPassword(

          register: register);
      // _getAuthenticatedUser();
      // _optionScreens();
      await Get.offAllNamed(AppRoutes.LOGIN);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      final errorMessage = UserAuthFailureException.code(e.code);
      DialogHelper.showErrorDialog(description: errorMessage.message);
    } on SocketException {
      DialogHelper.showErrorDialog(description: "No internet connection.");
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      UserCredential? userCredential =
      await _authenticationService.signInWithGoogle(context);

      if (userCredential != null) {
        Future.delayed(const Duration(milliseconds: 7));

        if (userCredential.additionalUserInfo!.isNewUser) {
          log("::::::::::::::::::GOOGLE: New Google user auth.::::::::::::");
          // await initializeNewUser();
          _getAuthenticatedUser();
          _optionScreens();
          //DialogHelper.showErrorDialog(description: "Welcome to Poupey App.");
        } else {
          _getAuthenticatedUser();
          _optionScreens();
        }
      }
    } on FirebaseAuthException catch (e, stack) {
      log('LOG', name: "GOOGLE AUTH", error: jsonEncode(stack));
      final errorMessage = UserAuthFailureException.code(e.code);
      DialogHelper.showErrorDialog(description: errorMessage.message);
    } on Exception catch (e) {
      print(e);
    }
  }

  // Future signInWithFacebook(BuildContext context) async {
  //   try {
  //     UserCredential? userCredential =
  //         await _authenticationService.signInWithFacebook(context);
  //
  //     if (userCredential != null) {
  //       Future.delayed(const Duration(milliseconds: 7));
  //
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         log("::::::::::::::::::FACEBOOK: New Facebook user auth.::::::::::::");
  //         await initializeNewUser();
  //         _getAuthenticatedUser();
  //         _optionScreens();
  //         //DialogHelper.showErrorDialog(description: "Welcome to Poupey App.");
  //       } else {
  //         _getAuthenticatedUser();
  //         _optionScreens();
  //       }
  //     }
  //   } on FirebaseAuthException catch (e, stack) {
  //     log('LOG', name: "FACEBOOK AUTH", error: jsonEncode(stack));
  //     final errorMessage = UserAuthFailureException.code(e.code);
  //     DialogHelper.showErrorDialog(description: errorMessage.message);
  //   }
  // }
  //
  // Future signInWithTwitter(BuildContext context) async {
  //   try {
  //     UserCredential? userCredential =
  //         await _authenticationService.signInWithTwitter(context);
  //
  //     if (userCredential != null) {
  //       Future.delayed(const Duration(milliseconds: 7));
  //
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         log("::::::::::::::::::TWITTER: New Twitter user auth.::::::::::::");
  //
  //         await initializeNewUser();
  //
  //         _getAuthenticatedUser();
  //         _optionScreens();
  //       } else {
  //         _getAuthenticatedUser();
  //         _optionScreens();
  //       }
  //     }
  //   } on FirebaseAuthException catch (e, stack) {
  //     log('LOG', name: "TWITTER AUTH", error: jsonEncode(stack));
  //     final errorMessage = UserAuthFailureException.code(e.code);
  //     DialogHelper.showErrorDialog(description: errorMessage.message);
  //   }
  // }

  signOut() async {
    try {
      await _authenticationService.signOut();
      _getAuthenticatedUser();
      _optionScreens();
    } on FirebaseAuthException catch (e) {
      log(e.message!);
    }
  }

// initializeNewUser() async {
//   try {
//     final UserService userService = UserService();
//     DialogHelper.showLoading();
//     dio.Response response = await userService.initializeNewUser();
//     if (response.statusCode == StatusCode.CREATED) {
//       DialogHelper.hideLoading();
//     }
//     //DialogHelper.showErrorDialog(description: "Welcome to Poupey App.");
//   } catch (e) {}
// }
}
