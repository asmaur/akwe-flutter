import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../models/auth_user.dart';
import '../../models/user_data/user_login_model.dart';
import '../../models/user_data/user_register_model.dart';
import 'authentication_provider.dart';
import 'firebase_auth_provider.dart';

class AuthenticationService extends GetxService implements AppAuthProvider {
  final AppAuthProvider provider;

  AuthenticationService(this.provider);

  factory AuthenticationService.firebase() =>
      AuthenticationService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  User? get getCurrentUser => provider.getCurrentUser;

  @override
  Future<void> signOut() async {
    await provider.signOut();
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

  @override
  Future<UserCredential?> signInWithEmail({
    required UserLoginModel login
  }) =>
      provider.loginInWithEmailAndPassword(login: login);

  @override
  Future<AuthUser> signUpWithEmail(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmail
    throw UnimplementedError();
  }

  // @override
  // Future<UserCredential?> signInWithFacebook(BuildContext context) async{
  //   return provider.signInWithFacebook(context);
  // }
  //
  //
  // @override
  // Future<UserCredential?> signInWithTwitter(BuildContext context) async{
  //   // TODO: implement signUpWithTwitter
  //   return await provider.signInWithTwitter(context);
  // }

  @override
  Future<UserCredential?> loginInWithEmailAndPassword({
    required UserLoginModel login
  }) =>
      provider.loginInWithEmailAndPassword(
          login: login
      );

  @override
  Future<UserCredential?> registerWithEmailAndPassword({required UserRegisterModel register}
      //     {
      //   required String name,
      //   required String email,
      //   required String password,
      // }
      ) async {
    return await provider.registerWithEmailAndPassword(register: register);
  }

  @override
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    // TODO: implement signInWithGoogle
    return await provider.signInWithGoogle(context);
  }
}
