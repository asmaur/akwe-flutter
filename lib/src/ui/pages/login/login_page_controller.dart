import 'package:akwe/src/data/services/user_service.dart';
import 'package:akwe/src/globals/app_authentication_service.dart';
import 'package:akwe/src/models/user_data/user_login_model.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import '../../../exceptions/network_exceptions.dart';

class LoginPageController extends GetxController {
  final loginForm = FormGroup({
    "email": FormControl<String>(
        validators: [Validators.required, Validators.email]),
    "password": FormControl<String>(validators: [Validators.required])
  });

  AuthButtonStyle? authButtonStyle;
  final appService = AppAuthenticationService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> login() async {
    try {
      if (loginForm.valid) {
        DialogHelper.showLoading();
        await appService.loginWithEmail(
          UserLoginModel(email: loginForm.control("email").value, password: loginForm.control("password").value),
        );
        DialogHelper.hideLoading();
      }
    } catch (e) {
      DialogHelper.hideLoading();
      // final errorMessage = DioExceptions.fromDioError(e);
      // DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
      print(e);
    }
  }
}
