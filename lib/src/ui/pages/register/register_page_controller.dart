import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';

import '../../../globals/app_authentication_service.dart';
import '../../../models/user_data/user_register_model.dart';
import '../../shared/dialog_helper.dart';

class RegisterPageController extends GetxController {
  final registerForm = FormGroup(
    {
      "name": FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(5),
        ],
      ),
      "email": FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      "password": FormControl<String>(validators: [Validators.required]),
    },
  );

  AuthButtonStyle? authButtonStyle;
  final authService = Get.find<AppAuthenticationService>();

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

  Future<void> register() async {
    try {
      if (registerForm.valid) {
        DialogHelper.showLoading();
        await authService.registerWithEmail(
          UserRegisterModel(
            name: registerForm.control("name").value,
            email: registerForm.control("email").value,
            password: registerForm.control("password").value,
          ),
        );
      } else {
        DialogHelper.hideLoading();
        registerForm.markAllAsTouched();
      }
    } catch (e) {
      DialogHelper.hideLoading();
      print(e);
    }
  }
}
