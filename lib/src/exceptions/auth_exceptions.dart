import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class UserAuthFailureException{
  final String message;

  UserAuthFailureException([this.message = '']);

  factory UserAuthFailureException.code(String code){
    switch(code){
      case 'weak-password' : return UserAuthFailureException(translation.authWeakPasswordMessage.tr);
      case 'invalid-email' : return UserAuthFailureException(translation.authInvalidEmailMessage.tr);
      case 'email-already-in-use' : return  UserAuthFailureException(translation.authEmailAlreadyInUseMessage.tr);
      case 'user-not-found' : return UserAuthFailureException(translation.authUserNotFoundMessage.tr);
      case 'user-disabled' : return UserAuthFailureException(translation.authUserDisabledMessage.tr);
      case 'operation-not-allowed' : return UserAuthFailureException(translation.authOperationNotAllowedMessage.tr);
      case 'account-exists-with-different-credential': return UserAuthFailureException(translation.authAccountExistsWithDifferentCredentialMessage.tr);
      case 'invalid-credential': return UserAuthFailureException(translation.authInvalidCredentialMessage.tr);
      case 'user-mismatch': return UserAuthFailureException(translation.authUserMismatchMessage.tr);
      case 'wrong-password': return UserAuthFailureException(translation.authWrongPasswordMessage.tr);
      case 'network-request-failed': return UserAuthFailureException(translation.appNetworkErrorNoInternetConnection.tr);

      default: return UserAuthFailureException(translation.authUnknownErrorMessage.tr);
    }
  }

}


class UserNotFoundAuthException implements Exception {}
class WrongPasswordAuthException implements Exception {}

// register
class WeakPasswordAuthException implements Exception {}
class EmailAlreadyInUseAuthException implements Exception {}
class InvalidEmailAuthException implements Exception {}

// generic user
class GenericAuthException implements Exception {}
class UserNotLoggedInAuthException implements Exception {}