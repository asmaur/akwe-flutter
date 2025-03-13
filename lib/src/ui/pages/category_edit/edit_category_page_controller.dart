import 'package:akwe/src/data/services/category_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/app_color.dart';
import 'package:akwe/src/utils/app_color_list.dart';
import 'package:akwe/src/utils/app_icon.dart';
import 'package:akwe/src/utils/app_icon_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';

class EditCategoryPageController extends GetxController {
  final CategoryService _service = CategoryService();
  final StorageService _storageService = StorageService();

  var name = TextEditingController();
  var description = TextEditingController();
  var income = false.obs;

  var category = AppCategory().obs;

  var selectedIndex = 0.obs;
  var selectedColor = AppColor(key: 70000, color: const Color(0xFF013F3A)).obs;
  var app_color_list = getAppColorList();
  var app_icon_list = getAppIconList();
  var selectedIcon = AppIcon(90011, Icons.home_outlined).obs;
  var selectedIconIndex = 0.obs;

  final form = fb.group({
    "name": FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(5),
      Validators.maxLength(20)
    ]),
    "income": FormControl<bool>(validators: [Validators.required]),
    "icon": FormControl<int>(validators: [Validators.required]),
    "color": FormControl<int>(validators: [Validators.required]),
    "description": FormControl<String>()
  });

  @override
  void onInit() {
    category.value = Get.arguments;
    // loadCategory();
    updateForm();
    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    description.dispose();
    super.onClose();
  }

  updateForm() {
    form.control("name").value = category.value.name!;
    form.control("income").value = category.value.income!;
    form.control("icon").value = category.value.icon?.key;
    form.control("color").value = category.value.color?.key;
    form.control("description").value = category.value.description!;

    selectedColor(category.value.color);
    selectedIcon(category.value.icon);
  }

  loadCategory() {
    name.text = category.value.name!;
    description.text = category.value.description!;
    income.value = category.value.income!;
    selectedColor(category.value.color);
    selectedIcon(category.value.icon);
  }

  updateSelectedColor(int index) {
    selectedIndex.value = index;
    selectedColor(app_color_list[index]);
    update();
  }

  updateSelectedIcon(int index) {
    selectedIconIndex.value = index;
    selectedIcon(app_icon_list[index]);
    update();
  }

  updateCategory() async {
    DialogHelper.showLoading();
    try {
      // var data = {};
      // data['name'] = name.text.trim();
      // data['description'] = description.text.trim();
      // data['income'] = income.value;
      var data = AppCategory(
              name: name.text.trim(),
              description: description.text.trim(),
              income: income.value,
              color: selectedColor.value,
              icon: selectedIcon.value)
          .toJson();

      dio.Response response = await _service.update(category.value.id!, data);

      if (response.statusCode == StatusCode.OK) {
        DialogHelper.hideLoading();
        // await _storageService.updateCategory(response.data, category.value.id!);
        Get.offAllNamed(AppRoutes.HOME);
        //Get.back();
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }
  }
}
