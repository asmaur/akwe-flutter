import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/category/category_page_controller.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});
  final controller = Get.find<CategoryPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.userCategoryPageTitle.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16.sp),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // if(controller.premiumService.isPremium.value) {
              //   Get.toNamed(AppRoutes.NEWCATEGORY);
              // }else {
              //   Get.toNamed(AppRoutes.USERPREMIUM);
              // }
              Get.toNamed(AppRoutes.NEWCATEGORY);
            },
            icon: Icon(
              FontAwesomeIcons.plus,
              // size: 14.sp,
            ),
          )
        ],
      ),
      // resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => {},
      //   label: Text("Novo"),
      //   icon: Icon(Icons.add),
      // ),
      body: Obx(() => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
      color: AppColors.appDarkGreen,
                  ),
                )
              : ListView.builder(
                  itemCount: controller.categoryItems.length,
                  itemBuilder: (_, index) {
      return ListTile(
        leading: Container(
          decoration: BoxDecoration(
              color: controller.categoryItems[index].color?.color,
              borderRadius: BorderRadius.circular(50)),
          width: 10.w,
          height: 10.w,
          child: Icon(
            controller.categoryItems[index].icon?.icon,
            color: AppColors.appWhite,
            size: 20.sp,
          ),
        ),
        title: Text(controller.categoryItems[index].name!),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: CategoryPopupMenuItem.edit,
                child: Text(translation.appEditButtonLabel.tr),
              ),
              PopupMenuItem(
                value: CategoryPopupMenuItem.archived,
                child: Text(translation.appDeleteButtonLabel.tr),
              )
            ];
          },
          onSelected: (CategoryPopupMenuItem value) =>
              actionPopUpItemSelected(
                  value, controller.categoryItems[index]),
        ),
        onTap: () {
          Get.toNamed(AppRoutes.EDITCATEGORY,
              arguments: controller.categoryItems[index]);
        },
      );
                  },
                )),
    );
  }

  void actionPopUpItemSelected(
      CategoryPopupMenuItem value, AppCategory category) {
    final controller = Get.put(CategoryPageController());

    if (value == CategoryPopupMenuItem.edit) {
      Get.toNamed(AppRoutes.EDITCATEGORY, arguments: category);
    } else if (value == CategoryPopupMenuItem.archived) {
      //print(category.isDefault);
      DialogHelper.showErrorDialog(
        title: translation.userCategoryDeleteConfirmText.tr,
        description: translation.userCategoryDeleteDescriptionText
            .trParams({"name": "${category.name}"}), // ${category.name}?",
        onConfirm: () => category.isDefault!
            ? DialogHelper.showSnackBar(
                title: translation.appMessageError.tr,
                message: translation.appItemDefault.tr,
              )
            : controller.archiveCategory(category.id!),
      );
    } else {
      print("message");
    }
  }
}
