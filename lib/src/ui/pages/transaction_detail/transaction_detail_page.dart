
import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/transaction_detail/transaction_detail_page_controller.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:akwe/src/ui/widgets/components/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionDetailPageController());
    final locale = Get.deviceLocale;

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );
    AppPopupMenuItem? selectedItem;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            translation.appTransactionDetailTitle.trParams({
              'code': "${controller.transaction.value.code}",
            }),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
          ),
          actions: [
            (controller.transaction.value.auto! &&
                    controller.transaction.value.processed!)
                ? OutlinedButton(
                    onPressed: () {
                      controller.loadTransactionItems();
                    },
                    child: Text(translation.appTransactionDetailShowItems.tr),
                  )
                : const SizedBox(),
            PopupMenuButton(
              initialValue: selectedItem,
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: AppPopupMenuItem.edit,
                    child: Text(translation.appPopupMenuEditText.tr),
                  ),
                  PopupMenuItem(
                    value: AppPopupMenuItem.delete,
                    child: Text(translation.appPopupMenuDeleteText.tr),
                  )
                ];
              },
              onSelected: (AppPopupMenuItem item) {
                switch (item) {
                  case AppPopupMenuItem.edit:
                    controller.goToEditPage();
                    return;
                  case AppPopupMenuItem.delete:
                    actionPopUpItemSelected(
                      //AppPopupMenuItem.Delete,
                      controller.transaction.value,
                    );
                    return;
                  case AppPopupMenuItem.view:
                    // TODO: Handle this case.
                  case AppPopupMenuItem.archived:
                    // TODO: Handle this case.
                  case AppPopupMenuItem.all:
                    // TODO: Handle this case.
                  case AppPopupMenuItem.pPrevious:
                    // TODO: Handle this case.
                  case AppPopupMenuItem.restore:
                    // TODO: Handle this case.
                }
              },
            )
          ],
        ),
        body: controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.appDarkGreen
                      : Colors.white,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        const Gap(5),
                        Center(
                          child: Text(translation.appTransactionDetailName
                              .trParams({
                            "name": "${controller.transaction.value.name}"
                          })),
                        ),
                        controller.showLink.value
                            ? ListTile(
                                title: Text(
                                    translation.appTransactionDetailLink.tr),
                                subtitle: Text(
                                  controller.transaction.value.invoiceUrl!,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.appBlue
                                        : AppColors.appWhite,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Container(),
                        //Gap(10),
                        Gap(AppLayout.getHeight(10)),

                        controller.showDescription.value
                            ? Card(
                                elevation: 0,
                                child: ListTile(
                                  title: Text(translation
                                      .appTransactionDetailDescription.tr),
                                  subtitle: Text(controller
                                      .transaction.value.description!),
                                ),
                              )
                            : Container(),

                        controller.transaction.value.processed!
                            ? Card(
                                child: Column(
                                  children: [
                                    const Gap(5),
                                    Center(
                                      child: Text(translation
                                          .appTransactionDetailSummary.tr),
                                    ),
                                    ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Text(translation
                                          .appTransactionDetailTotalValor.tr),
                                      trailing: Text(currency.format(controller
                                          .transaction.value.totalValue)),
                                    ),
                                    ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Text(translation
                                          .appTransactionDetailDiscount.tr),
                                      trailing: Text(
                                        currency.format(controller
                                            .transaction.value.discount),
                                      ),
                                    ),
                                    ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Text(translation
                                          .appTransactionDetailTotalPayed.tr),
                                      trailing: Text(
                                        currency.format(controller
                                            .transaction.value.totalPayed),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Card(
                                child: ListTile(
                                  title: Text(translation
                                      .appTransactionInvoiceUnprocessedTitle
                                      .tr),
                                  subtitle: Text(translation
                                      .appTransactionInvoiceUnprocessedSubTitle
                                      .tr),
                                ),
                              ),

                        Gap(20),

                        (!controller.transaction.value.processed! &&
                                controller.transaction.value.auto!)
                            ? SizedBox(
                                width: AppLayout.getScreenWidth() * 0.5,
                                child: SizedBox(
                                  width: AppLayout.getWidth(150),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        AppRoutes.INVOICEVIEW,
                                        arguments: {
                                          "invoice_url": controller.transaction.value.invoiceUrl,
                                          // "http://nfe.sefaz.ba.gov.br/servicos/nfce/modulos/geral/NFCEC_consulta_chave_acesso.aspx?p=29220411724258005701651010000491291679258238|2|1|1|5d5b282c2d50575b125123b3535a533c034e2473",
                                          // "https://dfe-portal.svrs.rs.gov.br/Dfe/QrCodeNFce?p=43250193015006000547651090007960061976260584%7C2%7C1%7C1%7C73CC0E08379F65C615A613C23DFF1D1D716DFF67",
                                          // controller.transaction.value.invoiceUrl,
                                          "id": controller.transaction.value.id
                                        },
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          Colors.deepOrangeAccent.shade700,
                                      side: const BorderSide(
                                          color: Colors.transparent),
                                    ),
                                    child: Text(
                                      translation
                                          .appTransactionDetailProcess.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: AppColors.appWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),

                                // ElevatedButton(
                                //   onPressed: () {
                                //     Get.toNamed(
                                //       Routes.INVOICEVIEW,
                                //       arguments: {
                                //         "invoice_url":
                                //             controller.transaction.value.invoiceUrl,
                                //         "id": controller.transaction.value.id
                                //       },
                                //     );
                                //   },
                                //   child: Text(
                                //       translation.appTransactionDetailProcess.tr),
                                // ),
                              )
                            : Container(),

                        Gap(AppLayout.getHeight(10)),

                        // AppAdManager().getAdaptiveBannerAd(),

                        controller.items.value.isNotEmpty
                            ? Column(
                                children: [
                                  Center(
                                    child: Text(
                                      translation.appTransactionDetailItems.tr,
                                    ),
                                  ),
                                  for (int index = 0;
                                      index < controller.items.value.length;
                                      index++) ...[
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: AppLayout.getHeight(20),
                                          right: AppLayout.getHeight(20)),
                                      child: ItemTile(
                                        itemName: controller
                                            .items.value[index].description,
                                        price: controller
                                            .items.value[index].totalPrice!,
                                        marketName: controller.items
                                            .value[index].company?.description,
                                      ),
                                    ),
                                  ]
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void actionPopUpItemSelected(
    //AppPopupMenuItem value,
    Transaction transaction,
  ) {
    final controller = Get.find<TransactionDetailPageController>();
    // if(controller.premiumService.isPremium.value) {
      DialogHelper.showErrorDialog(
        title: translation.userCategoryDeleteConfirmText.tr,
        onConfirmText: translation.appDeleteButtonLabel.tr,
        onCancelText: translation.appCancelButtonLabel.tr,
        showCancel: true,
        description: translation.appTransactionDeleteDescriptionText
            .trParams({"name": "${transaction.code}"}),
        // ${category.name}?",
        onConfirm: () => controller.deleteTransaction(transaction.id!),
        onCancel: () => Get.back(),);
    // }else{
    //   Get.toNamed(AppRoutes.USERPREMIUM);
    // }


    // } else {
    //   print("message");
    // }
    // final snackBar = SnackBar(content: Text(message));
    // _scaffoldkey.currentState.showSnackBar(snackBar);
  }
}
