import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../firebase_options.dev.dart';
import '../../models/user_data/user_login_model.dart';
import '../../models/user_data/user_register_model.dart';
import '../../ui/shared/dialog_helper.dart';
import '../../utils/status_code.dart';
import '../services/user_service.dart';
import 'authentication_provider.dart';
import "authentication_service.dart";

class FirebaseAuthProvider implements AppAuthProvider {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  // TODO: implement currentUser
  User? get getCurrentUser {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return user; //User.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    // final user = firebaseAuth.currentUser;
    // if (user != null) {
    //   await firebaseAuth.signOut();
    // }
  }

  @override
  Future<void> sendPasswordReset() {
    // TODO: implement sendPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<void> sendVerificationEmail() {
    // TODO: implement sendVerificationEmail
    throw UnimplementedError();
  }

  // @override
  // Future<UserCredential?> signInWithFacebook(BuildContext context) async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //   return await FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential);
  // }
  //
  // @override
  // Future<UserCredential?> signInWithTwitter(BuildContext context) async {
  //   try {
  //     final twitterLogin = TwitterLogin(
  //       apiKey: AppConstants.twitterApiKey,
  //       apiSecretKey: AppConstants.twitterApiSecretKey,
  //       redirectURI: "ubba://",
  //     );
  //     AuthResult authResult = await twitterLogin.login();
  //
  //     switch (authResult.status){
  //       case TwitterLoginStatus.loggedIn:
  //         log(":::::::LOG: TWITTER LOGGED IN.");
  //         final twitterAuthCredential = TwitterAuthProvider.credential(
  //           accessToken: authResult.authToken!,
  //           secret: authResult.authTokenSecret!,
  //         );
  //         return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  //
  //       case TwitterLoginStatus.cancelledByUser:
  //         log(":::::::LOG: TWITTER LOGGING CANCELLED BY USER.");
  //         return null;
  //       case TwitterLoginStatus.error:
  //         log("::::::::::LOG: TWITTER SOMETHING WENT WRONG.");
  //         return null;
  //     }
  //
  //     //return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  //   }catch(e){
  //     //log("TWITTER LOG: ", "", jsonEncode(stack));
  //     debugPrint(e.toString());
  //     //debugPrintStack(stack);
  //   }
  //   return null;
  //
  // }

  @override
  Future<UserCredential?> loginInWithEmailAndPassword(
      {required UserLoginModel login}) async {
    final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: login.email,
      password: login.password,
    );
    if(userCredential.user == null){
      return null;
    }
    return userCredential;
  }

  @override
  Future<UserCredential?> registerWithEmailAndPassword({
    required UserRegisterModel register
  }) async {

    try {
      final UserCredential userCredential =
      await firebaseAuth.createUserWithEmailAndPassword(
          email: register.email, password: register.password);
      if (userCredential.user != null) {
        userCredential.user?.updateDisplayName(register.name);
        var response = await initializeNewUserWithEmail({
          "name": register.name,
          "email": register.email,
          "password": register.password,
          "uid": userCredential.user?.uid
        });

        if (response == null || response != StatusCode.CREATED) {
          await userCredential.user?.delete();
          return null;
        }
      }
      return userCredential;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  @override
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
        return userCredential;
        // for sign up
        // if(userCredential != null){
        //   if(userCredential.additionalUserInfo!.isNewUser){}
        // }
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
    //return null;
  }

  Future<int?> initializeNewUserWithEmail(Map<String, dynamic> data) async {
    try {
      final UserService userService = UserService();
      DialogHelper.showLoading();
      dio.Response response =
      await userService.initializeUserWithEmailAndPassword(data);
      if (response.statusCode == StatusCode.CREATED) {
        DialogHelper.hideLoading();
        // return StatusCode.CREATED;
      }
      return response.statusCode;
      //DialogHelper.showErrorDialog(description: "Welcome to Poupey App.");
    } catch (e) {
      print(e);
      return null;
    }
  }
}
