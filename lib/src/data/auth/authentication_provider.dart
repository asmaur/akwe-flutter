import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../models/user_data/user_login_model.dart';
import '../../models/user_data/user_register_model.dart';

abstract class AppAuthProvider{
  Future<void> initialize();

  User? get getCurrentUser;

  Future<UserCredential?> registerWithEmailAndPassword({required UserRegisterModel register}
      // {required String name, required String email, required String password}
      );

  Future<void> sendVerificationEmail();

  Future<UserCredential?> loginInWithEmailAndPassword({required UserLoginModel login});

  Future<void> sendPasswordReset();

  Future<UserCredential?> signInWithGoogle(BuildContext context);

  // Future<UserCredential?> signInWithFacebook(BuildContext context);
  //
  // Future<UserCredential?> signInWithTwitter(BuildContext context);

  Future<void> signOut();
}