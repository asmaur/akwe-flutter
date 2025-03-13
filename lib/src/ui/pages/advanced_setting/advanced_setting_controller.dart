import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:poupey/src/exceptions/network_exceptions.dart';
import 'package:poupey/src/helpers/dialog_helper.dart';
import 'package:poupey/src/routes/app_pages.dart';
import 'package:poupey/src/services/networking/apiservice/user_service.dart';
import 'package:poupey/src/translations/translation_keys.dart' as translation;
import 'package:poupey/src/utils/status_code.dart';

class AdvancedSettingController extends GetxController {
  final _userService = UserService();

  Future resetDataAction() async {
    DialogHelper.showErrorDialog(
      title: translation.userCategoryDeleteConfirmText.tr,
      description: translation.appAdvancedSettingResetConsent.tr,
      onConfirm: () => resetUserData(),
    );
  }

  Future resetUserData() async {
    DialogHelper.showLoading();
    try {
      dio.Response response = await _userService.resetUserData();

      if (response.statusCode == StatusCode.CREATED) {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appAdvancedSettingResetSuccessMessage.tr,
        );
        Get.offAllNamed(Routes.HOME);
      }
    } on dio.DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(
        title: translation.appMessageError.tr,
        description: errorMessage.message,
      );
    }
  }
}
