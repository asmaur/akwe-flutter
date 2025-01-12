import 'package:akwe/src/data/services/category_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:get_storage/get_storage.dart';

class CategoryPageController extends GetxController{

  // final premiumService = Get.find<AppPremiumService>();
  final CategoryService _service = CategoryService();
  final StorageService _storageService = StorageService();
  var categoryItems = <AppCategory>[].obs;
  var isLoading = true.obs;
  // final _storage = GetStorage();

  get premiumService => null;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    getUserCategories();
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> getUserCategories() async {
    try {

      // var storeCategoryList = await _storageService.getCategoryList();
      List<dynamic> items = [];

      items = await _storageService.list("categories");

      if(items.isEmpty){
        var response = await _service.get();
        items = response.data;
        await _storageService.setList("categories", items);
      }

        categoryItems.clear();
        for (var item in items) {
          categoryItems.add(AppCategory.fromJson(item));
        }

      isLoading.value = false;
      update();

    } on dio.DioException catch (e) {
      isLoading.value = false;
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);

    }
  }

  archiveCategory(String id) async{
    DialogHelper.showLoading();
    try{
      dio.Response response = await _service.delete(id);

      if(response.statusCode == StatusCode.NO_CONTENT){

        await _service.delete(id);
        DialogHelper.hideLoading();
        Get.offAllNamed(AppRoutes.HOME);
      }

    }on dio.DioException catch(e){
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    }
  }


}