import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class DialogHelper {

  static void showSuccessDialog({
    String? title = "",
    String? description = "",
    String? onConfirmText = "Okay",
    String? onCancelText = "Cancelar",
    bool showCancel = false,
    final Function()? onConfirm,
    final Function()? onCancel,
  }) {
    Get.dialog(Dialog(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title!,
              style: Get.textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Divider(),
            Gap(10),
            Center(
              child: Text(
                description ?? '',
                style: Get.textTheme.bodyMedium,
              ),
            ),
            const Divider(),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showCancel
                    ? ElevatedButton(
                  onPressed: () {
                    if (Get.isDialogOpen!) Get.back();
                    onCancel == null ? null : onCancel();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.appRed),
                  ),
                  child: Text(
                    onCancelText!,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: AppColors.appRed),
                  ),
                )
                    : const SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    if (Get.isDialogOpen!) Get.back();
                    onConfirm == null ? null : onConfirm();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.appBlack,
                    side: const BorderSide(color: Colors.transparent),
                  ),
                  child: Text(
                    onConfirmText!,
                    style:
                    Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                      color: AppColors.appWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }


  static void showErrorDialog({
    String title = "",
    String? description = "",
    String? onConfirmText = "Okay",
    String? onCancelText = "Cancelar",
    bool showCancel = false,
    final Function()? onConfirm,
    final Function()? onCancel,
  }) {
    Get.dialog(Dialog(
      child: Padding(
        padding: EdgeInsets.all(AppLayout.getHeight(2)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Get.textTheme.titleLarge?.copyWith(
                color: Colors.redAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Divider(),
            Gap(AppLayout.getHeight(2)),
            Center(
              child: Text(
                description ?? '',
                style: Get.textTheme.bodyMedium,
              ),
            ),
            const Divider(),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showCancel
                    ? ElevatedButton(
                        onPressed: () {
                          if (Get.isDialogOpen!) Get.back();
                          onCancel == null ? null : onCancel();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.appRed),
                        ),
                        child: Text(
                          onCancelText!,
                          style: Theme.of(Get.context!)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: AppColors.appRed),
                        ),
                      )
                    : const SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    if (Get.isDialogOpen!) Get.back();
                    onConfirm == null ? null : onConfirm();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.appRed,
                    side: const BorderSide(color: Colors.transparent),
                  ),
                  child: Text(
                    onConfirmText!,
                    style:
                        Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                              color: AppColors.appWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  static void showLoading([String? message]) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: Padding(
          padding: EdgeInsets.all(AppLayout.getHeight(2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              Gap(10),
              Text(message ?? translation.appMessageLoading.tr),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  static void showSnackBar({
    String? title = "",
    String? message = "",
    Color color = const Color(0xFF303030),
    int? duration = 3,
    bool isDismissible = true,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        backgroundColor: color,
        duration: Duration(seconds: duration!),
        isDismissible: isDismissible,
      ),
    );
  }
}
