import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/popup_menu.dart';
import 'package:akwe/src/routes/app_pages.dart';
import 'package:akwe/src/ui/pages/account/account_page_view_controller.dart';
import 'package:akwe/src/ui/widgets/components/account_tile_large.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

class AccountPageView extends StatelessWidget {
  AccountPageView({super.key});
  final controller = Get.find<AccountPageViewController>();
  // late final FilterPopupMenuItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            translation.userAccountTitleText.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),
          ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.loadNewAccount();
          },
          backgroundColor: AppColors.appDarkGreen,
          child: const Icon(Icons.add),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Obx(
              () => controller.isLoading.value
              ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.appDarkGreen,
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: controller.userAccounts.length,
            itemBuilder: (BuildContext context, int index) {
              return AccountTileLarge(
                account: controller.userAccounts[index],
              );
            },
          ),
        )
    );
  }

  // popupMenu() {
  //   FilterPopupMenuItem? selectedItem;
  //   PopupMenuButton(
  //     initialValue: selectedItem,
  //     icon: const Icon(Icons.more_vert),
  //     itemBuilder: (context) {
  //       return [
  //         const PopupMenuItem(
  //           value: FilterPopupMenuItem.all,
  //           child: Text("See all"),
  //         ),
  //         const PopupMenuItem(
  //           value: FilterPopupMenuItem.previous,
  //           child: Text("See previous"),
  //         )
  //       ];
  //     },
  //     onSelected: (FilterPopupMenuItem item) {
  //       switch (item) {
  //         case FilterPopupMenuItem.all:
  //           Get.toNamed(AppRoutes.TRANSACTIONALL);
  //           return;
  //         case FilterPopupMenuItem.previous:
  //           Get.toNamed(AppRoutes.TRANSACTIONFILTER);
  //           return;
  //       }
  //     },
  //   );
  //
  // }
}
