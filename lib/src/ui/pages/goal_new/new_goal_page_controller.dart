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
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';


class NewGoalPageController extends GetxController{
  final GoalService _goalService = GoalService();
  final StorageService _storageService = StorageService();
  var amount = TextEditingController(text: "0");
  var goalName = TextEditingController();
  var description = TextEditingController();
  var startDate = DateTime.now().add(const Duration(days: 1)).obs;
  TextEditingController dateInput = TextEditingController();
  var selectedIndex = 0.obs;
  var selectedColor = AppColor(key: 70000, color: const Color(0xFF013F3A)).obs;
  var app_color_list = getAppColorList();
  var app_icon_list = getAppIconList();
  var selectedIcon = AppIcon(90011, Icons.home_outlined).obs;
  var selectedIconIndex = 0.obs;

  var categories = <AppCategory>[].obs;
  var selectedCategory = "".obs;

  // late FocusNode focusNode;

  final form = fb.group(<String, Object>{
    'target_amount': FormControl<double>(value: null, validators: [
      Validators.required,
      Validators.number(allowNegatives: false, allowedDecimals: 1,),]),
    'name': FormControl<String>(validators: [Validators.required]),
    'description': FormControl<String>(),
    'category_id': FormControl<String>(validators: [Validators.required]),
    'deadline_date': FormControl<DateTime>(validators: [Validators.required]),
    'icon': FormControl<int>(validators: [Validators.required]),
    'color': FormControl<int>(validators: [Validators.required]),
  });


  @override
  void onInit() {
    loadCategories();
    // focusNode = FocusNode();
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

  loadCategories() async {
    var values = await _storageService.list("categories");
    if (values.isNotEmpty) {
      //var items = values.where((e) => e['income'] == income.value).toList();
      for (var element in values) {
        categories.add(AppCategory.fromJson(element));
      }
      selectedCategory.value = categories.first.id!;
      form.control('category_id').value = selectedCategory.value;
      form.control('icon').value = selectedIcon.value.key;
      form.control('color').value = selectedColor.value.key;
    }
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

  updateCategory(String id) {
    selectedCategory.value = id;
    // buildForm().control('color').value = selectedCategory.value;
    update();
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      locale: Get.locale,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
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

  createNewGoal() async{
    try {
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
      ).toJson();
      data['category_id'] = selectedCategory.value;

      dio.Response response = await _goalService.create(data);

      if (response.statusCode == StatusCode.CREATED) {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appGoalSuccessLabelMessage.tr,
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

  testSavedForm(){
    print(form.value);
  }


}