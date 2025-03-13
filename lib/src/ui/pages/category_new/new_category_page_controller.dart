import 'dart:math';

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


class NewCategoryPageController extends GetxController{
  final CategoryService _service = CategoryService();
  final StorageService _storageService = StorageService();
  final colorList = getAppColorList();
  final _random = Random();

  var name = TextEditingController();
  var description = TextEditingController();
  var income = false.obs;

  var selectedIndex = 0.obs;
  var selectedColor = AppColor(key: 70000, color: const Color(0xFF013F3A)).obs;
  var app_color_list = getAppColorList();
  var app_icon_list = getAppIconList();
  var selectedIcon = AppIcon(90011, Icons.home_outlined).obs;
  var selectedIconIndex = 0.obs;

  final form = fb.group({
    "name": FormControl<String>(validators: [Validators.required, Validators.minLength(5), Validators.maxLength(20)]),
    "income": FormControl<bool>(validators: [Validators.required]),
    "icon": FormControl<int>(validators: [Validators.required]),
    "color": FormControl<int>(validators: [Validators.required]),
    "description": FormControl<String>()
  });

  @override
  onClose(){
    // name.dispose();
    // description.dispose();
    form.control('icon').value = selectedIcon.value.key;
    form.control('color').value = selectedColor.value.key;
    super.onClose();
  }


  toggle() {
    income.value = !income.value;
    update();
  }

  updateSelectedColor(int index){
    selectedIndex.value = index;
    selectedColor(app_color_list[index]);
    form.control('color').value = selectedColor.value.key;
    update();
  }

  updateSelectedIcon(int index){
    selectedIconIndex.value = index;
    selectedIcon(app_icon_list[index]);
    form.control('icon').value = selectedIcon.value.key;
    update();
  }

  createCategory() async{
    DialogHelper.showLoading();
    try {
      // var data = {};
      // data['name'] = name.text.trim();
      // data['income'] = income.value;
      // data['description'] = description.text.trim();
      // data['color'] = colorList[_random.nextInt(colorList.length)].key;

      // var data = AppCategory(
      //     name: name.text.trim(),
      //     income: income.value,
      //     description: description.text.trim(),
      //     // color: selectedColor.value,
      //     // icon: selectedIcon.value,
      // ).toJson();
      //
      // dio.Response response = await _service.create(data);
      //
      // if(response.statusCode == StatusCode.CREATED){
      //   // await _storageService.setCategory(response.data);
      //   Get.offAllNamed(AppRoutes.HOME);
      // }

      print(form.value);

    }on dio.DioException catch(e){
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }

}