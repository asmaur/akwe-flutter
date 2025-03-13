import 'dart:io';

import 'package:akwe/src/data/services/transaction_service.dart';
import 'package:akwe/src/data/storage/storage_service.dart';
import 'package:akwe/src/exceptions/network_exceptions.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/transaction_detail/transaction_detail_page_controller.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/utils/status_code.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:webview_flutter/webview_flutter.dart';

class InvoiceWebController extends GetxController {
  InAppWebViewController? webViewController;
  final StorageService _storageService = StorageService();
  final TransactionService _service = TransactionService();
  final TransactionDetailPageController _detailController =
      Get.find<TransactionDetailPageController>();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    // useShouldOverrideUrlLoading: true,
    // allowsInlineMediaPlayback: true,
    // useHybridComposition: true,
    // mediaPlaybackRequiresUserGesture: false,
    // allowFileAccess: true,
    // javaScriptEnabled: true,
    // clearCache: true,
    // clearSessionCache: true,
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  var webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        // onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.google.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )..setJavaScriptMode(JavaScriptMode.unrestricted);
    // ..loadRequest(Uri.parse('https://flutter.io'));

  var sourceHtml = "".obs;
  late PullToRefreshController pullToRefreshController;
  var invoiceUrl = "".obs;
  var id = Get.arguments['id'];
  var progress = 0.0.obs;
  final urlController = TextEditingController();
  var isRSInvoice = false.obs;
  var isUnified = true.obs;

  InAppWebViewController? _webViewController;

  @override
  void onInit() async {
    //invoiceUrl.value =
    var link = Get.arguments['invoice_url'];
    var host = Uri.parse(link).host;

    // if (host == Config.RSHost) {
    //   var params = Uri.parse(link).query;
    //   invoiceUrl.value = "${Config.RSFinalInvoiceEnpoint}$params";
    //   isUnified.value = false;
    //   //await getRSInvoiceLink();
    // } else {
    invoiceUrl.value = link;
    //}
    print(link);
    super.onInit();
  }

  getPageSourceCode() async {
    DialogHelper.showLoading();
    await createTransaction();

    DialogHelper.hideLoading();
  }

  confirmDialog(){
    DialogHelper.showSuccessDialog(
      title: "Confirm invoice",
      description: "Confirma que esta nota está correta e visivel?",
      showCancel: true,
      onConfirmText: "Sim",
      onCancelText: "Não",
      onConfirm: () async {
        await processDialog();
      },
      onCancel: () => DialogHelper.hideLoading()
    );
  }

  processDialog(){
    DialogHelper.showSuccessDialog(
      title: "Processar nota fiscal",
      description: "Deseja processar esta nota fiscal?",
      showCancel: true,
      onConfirmText: "Sim",
      onCancelText: "Não",
      onConfirm: () async {
        await getPageSourceCode();
      },
      onCancel: () => DialogHelper.hideLoading()
    );
  }

  createTransaction() async {
    try {
      // var transaction = Transaction(
      //         id: id,
      //         invoiceUrl: invoiceUrl.value,
      //         invoiceHtml: sourceHtml.value)
      //     .toJson();
      Map<String, dynamic> data = {};
      // data['id'] = id;
      // data['invoice_url'] = invoiceUrl.value;
      data['invoice_html'] = sourceHtml.value;
      // data['unified'] = isUnified.value;
      // debugPrint(sourceHtml.value);
      dio.Response response = await _service.updateTransaction(data, id);

      if (response.statusCode == StatusCode.ALREADY_PROCESSED) {
        DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: translation.appTransactionAlreadyProcessedText.tr,
        );
      }

      if (response.statusCode == StatusCode.OK) {
        var transaction = Transaction.fromJson(response.data);
        // await _storageService.updateTransaction(response.data);
        _detailController.transaction.value = transaction;
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(
          title: translation.appMessageSuccess.tr,
          message: translation.appMessageUpdateCreatedText.tr,
        );
        Get.offAllNamed(AppRoutes.HOME);
      }
    } on dio.DioException catch (e) {
      DialogHelper.hideLoading();
      final errorMessage = DioExceptions.fromDioError(e);
      DialogHelper.showErrorDialog(
          title: translation.appMessageError.tr,
          description: errorMessage.message);
    } on Exception catch (e) {
      print(e);
    }
  }
}
