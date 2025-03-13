import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' show log;
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'invoice_web_controller.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class InvoiceWebView extends StatelessWidget {
  const InvoiceWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceController =
        Get.put<InvoiceWebController>(InvoiceWebController());
    final GlobalKey webViewKey = GlobalKey();

    invoiceController.pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          invoiceController.webViewController?.reload();
        } else if (Platform.isIOS) {
          invoiceController.webViewController?.loadUrl(
              urlRequest: URLRequest(
                  url: await invoiceController.webViewController?.getUrl()));
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.appTransactionDetailInvoiceViewTitle.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              invoiceController.confirmDialog(); //getPageSourceCode();
            },
            child: Text(translation.appTransactionDetailInvoiceProcess.tr, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp,),),
          ),
        ],
      ),
      body: Expanded(
        child: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: WebUri(invoiceController.invoiceUrl.value)),
          onWebViewCreated: (InAppWebViewController controller) {
            controller._webViewController = controller;
          },
          onProgressChanged: (controller, progress) {
            // You can track loading progress here
          },
          onLoadStop: (controller, url) async{
            invoiceController.sourceHtml.value = (await controller.getHtml())!;
          },
        ),
      ),
      // WebViewWidget(
      //     controller: invoiceController.webController
      //       ..loadRequest(Uri.parse(invoiceController.invoiceUrl.value))),
      // SafeArea(
      //   child: Stack(
      //     children: [
      //     InAppWebView(
      //     key: webViewKey,
      //     initialUrlRequest:
      //     URLRequest(url: Uri.parse(invoiceController.invoiceUrl.value)),
      //       initialOptions: invoiceController.options,
      //     pullToRefreshController: invoiceController
      //         .pullToRefreshController,
      //     onWebViewCreated: (controller) {
      //       invoiceController.webViewController = controller;
      //     },
      //     onLoadStop: (controller, url) async {
      //       invoiceController.pullToRefreshController.endRefreshing();
      //           invoiceController.sourceHtml.value =
      //           (await controller.getHtml())!;
      //     },
      //     // onReceivedError: (controller, url, code, message) {
      //     //   invoiceController.pullToRefreshController.endRefreshing();
      //     // },
      //     onProgressChanged: (controller, progress) {
      //       if (progress == 100) {
      //         invoiceController.pullToRefreshController.endRefreshing();
      //       }
      //       invoiceController.progress.value = invoiceController.progress.value / 100;
      //
      //     },
      //     onUpdateVisitedHistory: (controller, url, androidIsReload) {},
      //     onConsoleMessage: (controller, consoleMessage) {
      //       log(consoleMessage.message);
      //     },
      //   ),
      //       invoiceController.progress.value < 1.0
      //       ? LinearProgressIndicator(value: invoiceController.progress.value)
      //       : Container(),
      //   ],
      //   ),
      // ),
    );
  }
}

extension on InAppWebViewController {
  set _webViewController(InAppWebViewController _webViewController) {}
}
