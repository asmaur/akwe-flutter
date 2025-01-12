import 'package:akwe/src/data/services/transfer_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/transfers/transfer.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class TransferPageController extends GetxController{
  final TransferService _service = TransferService();
  var transfers = <Transfer>[].obs;

  @override
  void onInit() {
    getTransfers();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getTransfers() async{
    try{
      dio.Response response = await _service.list();
      List<dynamic> items;

      if(response.statusCode == StatusCode.OK){
        transfers.clear();
        items = response.data;
        //items.forEach((element) => transfers.add(Transfer.fromJson(element)));
      }else{
        items = [];
      }

      if(items.isNotEmpty){
        for (var element in items) {
          transfers.add(Transfer.fromJson(element));
        }
      }

    } on dio.DioException catch(e){
      //DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(title: translation.appMessageError.tr, description: errorMessage.message);
    } catch(e, stack){
      print(stack);
    }


  }


}