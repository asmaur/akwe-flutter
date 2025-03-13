import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:timelines_plus/timelines_plus.dart';
import 'account_detail_page_controller.dart';


class AccountDetailPage extends StatelessWidget {
  AccountDetailPage({
    super.key
  });

  final AccountDetailPageController controller =
  Get.find<AccountDetailPageController>();
  final locale = Get.deviceLocale;

  @override
  Widget build(BuildContext context) {

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.userAccountDetailTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),),
        actions: const [
          // PopupMenuButton(
          //   icon: const Icon(Icons.more_vert),
          //   itemBuilder: (context) {
          //     return [
          //       PopupMenuItem(
          //         value: AccountPopupMenuItem.Edit,
          //         child: Text(translation.appEditButtonLabel.tr),
          //       ),
          //       PopupMenuItem(
          //         value: AccountPopupMenuItem.Archived,
          //         child: Text(translation.appDeleteButtonLabel.tr),
          //       )
          //     ];
          //   },
          //   onSelected: (AccountPopupMenuItem value) =>
          //       _controller.actionPopUpItemSelected(value),
          // )
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.appDarkGreen
                    : Colors.white,
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: AppLayout.getHeight(20), bottom: AppLayout.getHeight(20)),
                          child: Center(
                              child: Container(
                            width: AppLayout.getScreenWidth() * 0.8,
                            decoration: const BoxDecoration(
                              color: AppColors.appDarkGreen,
                            ),
                            child: ListTile(
                              dense: true,
                              visualDensity:
                                  const VisualDensity(horizontal: 0, vertical: -4),
                              title: Text(
                                controller.account.value.name!,
                                style: TextStyle(
                                  color: AppColors.appWhite,
                                  fontSize: AppLayout.getHeight(20),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              trailing: Text(
                                currency
                                    .format(controller.account.value.balance!),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppColors.appWhite,
                                      fontSize: AppLayout.getHeight(15),
                                    ),
                                // TextStyle(
                                //   color: AppColors.appBlack,
                                // ),
                              ),
                            ),
                          )),
                        ),
                        //Text("data"),
                      ],
                    ),
                    controller.account.value.histories != null
                        ? FixedTimeline.tileBuilder(
                            builder: TimelineTileBuilder.connectedFromStyle(
                              contentsAlign: ContentsAlign.alternating,
                              contentsBuilder: (context, index) => Padding(
                                padding: EdgeInsets.all(AppLayout.getHeight(24)),
                                child: Container(
                                    color: controller.account.value
                                            .histories![index].income!
                                        ? AppColors.appDarkGreen
                                        : AppColors.appRed,
                                    padding: EdgeInsets.all(AppLayout.getHeight(5)),
                                    child: Column(
                                      children: [
                                        Text(
                                          currency.format(controller.account
                                              .value.histories![index].amount!),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          DateFormat.yMMMd().format(controller
                                              .account
                                              .value
                                              .histories![index]
                                              .creationDate!),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              connectorStyleBuilder: (context, index) {
                                return (index == 1)
                                    ? ConnectorStyle.dashedLine
                                    : ConnectorStyle.solidLine;
                              },
                              indicatorStyleBuilder: (context, index) =>
                                  IndicatorStyle.dot,
                              itemCount:
                                  controller.account.value.histories!.length,
                            ),
                          )
                        : Center(
                            child: Container(
                              child: Text(translation.appHistoryPlaceHolderText.tr),
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }

// void actionPopUpItemSelected(
//     AccountPopupMenuItem value, AppAccount account) {
//   final _controller = Get.put(AccountDetailController());
//
//   if (value == CategoryPopupMenuItem.Edit) {
//     Get.toNamed(Routes.EDITCATEGORY, arguments: account);
//   } else if (value == CategoryPopupMenuItem.Archived) {
//     DialogHelper.showErrorDialog(
//       title: "Confirmação",
//       description: "Deseja arquivar a categoria: ${account.name}?",
//       onConfirm: () => _controller.archiveAccount(account.id!),
//     );
//   } else {
//     print("message");
//   }
//   // final snackBar = SnackBar(content: Text(message));
//   // _scaffoldkey.currentState.showSnackBar(snackBar);
// }
}
