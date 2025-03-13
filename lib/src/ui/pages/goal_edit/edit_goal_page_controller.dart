import 'package:akwe/src/data/services/goal_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/models/goals/app_goal.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/app_color.dart';
import 'package:akwe/src/utils/app_color_list.dart';
import 'package:akwe/src/utils/app_icon.dart';
import 'package:akwe/src/utils/app_icon_list.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;


class EditGoalPageController extends GetxController{
  final StorageService _storageService =
  StorageService();
  final GoalService _goalService = GoalService();

  var amount = TextEditingController(text: "0");
  var goalName = TextEditingController();
  var description = TextEditingController();
  var startDate = DateTime.now().obs;
  var dateInput = TextEditingController();
  var selectedIndex = 0.obs;
  var selectedColor = AppColor(key: 70000, color: const Color(0xFF013F3A)).obs;
  var app_color_list = getAppColorList();
  var app_icon_list = getAppIconList();
  var selectedIcon = AppIcon(90011, Icons.home_outlined).obs;
  var selectedIconIndex = 0.obs;
  var currentGoal = AppGoal().obs;

  var categories = <AppCategory>[].obs;
  var selectedCategory = AppCategory().obs;//0.obs;

  @override
  onInit(){
    loadCategories();
    currentGoal.value = Get.arguments;
    loadCurrentGoal();

    super.onInit();
  }

  @override
  onClose(){
    amount.dispose();
    goalName.dispose();
    description.dispose();
    super.onClose();
  }

  loadCurrentGoal(){
    amount.text = currentGoal.value.targetAmount.toString();
    goalName.text = currentGoal.value.name!;
    dateInput.text = DateFormat("dd/MM/yyyy").format(currentGoal.value.deadlineDate!);
    startDate.value = currentGoal.value.deadlineDate!;
    selectedColor(currentGoal.value.color);
    selectedIcon(currentGoal.value.icon);

    selectedCategory(currentGoal.value.category);

    setSelectedColorIndex(currentGoal.value.color!.key!);
    setSelectedIconIndex(currentGoal.value.icon!.key);

  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: startDate.value,
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != startDate.value) {
      startDate.value = pickedDate;
      print(startDate.value.toString());
      dateInput.text = DateFormat("dd/MM/yyyy").format(pickedDate);
    } else {
      print("Date is not selected");
    }
  }

  setSelectedColorIndex(int key){
    selectedIndex.value = app_color_list.indexWhere((element) => element.key == key);
  }

  setSelectedIconIndex(int key){
    selectedIconIndex.value = app_icon_list.indexWhere((element) => element.key == key);
  }

  updateSelectedColor(int index){
    selectedIndex.value = index;
    selectedColor(app_color_list[index]);
    update();
  }

  updateSelectedIcon(int index){
    selectedIconIndex.value = index;
    selectedIcon(app_icon_list[index]);
    update();
  }

  loadCategories() async {
    var values = await _storageService.list("categories");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        categories.add(AppCategory.fromJson(element));
      }
      //selectedCategory.value = categories.first.id!;
    }
  }

  // setCategory(int id) {
  //   selectedCategory.value = id;
  //   update();
  // }

  updateCategory(int id) {
    selectedCategory.value = categories.singleWhere((element) => element.id==id);
    update();
  }

  updateNewGoal() async{
    try{
      var data = AppGoal(
        name: goalName.text.trim(),
        targetAmount: double.tryParse(
            amount.value.text
                .trim()
                .removeAllWhitespace) ??
            0.0,

        icon: selectedIcon.value,
        color: selectedColor.value,
        deadlineDate: startDate.value,
        description: description.text.trim() ?? "",
        //categoryId: selectedCategory.value,
      ).toJson();

      data['category_id'] = selectedCategory.value.id;

      dio.Response response = await _goalService.update(currentGoal.value.id!, data);

      if (response.statusCode == StatusCode.OK) {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
            title: translation.appMessageSuccess.tr,
            message: "Goal succeffuly created"//translation.appRoutineProcessingMessage.tr,
        );
        Get.offAllNamed(AppRoutes.HOME);
      }

    }on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    }

  }


}