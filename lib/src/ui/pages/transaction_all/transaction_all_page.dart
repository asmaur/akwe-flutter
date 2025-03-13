import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/ui/pages/transaction_all/transaction_all_page_controller.dart';
import 'package:akwe/src/ui/widgets/components/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionAllPage extends StatelessWidget {
  const TransactionAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionAllPageController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("all transactions"),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: DropdownButton(
                value: controller.selectedItem.value,
                items: controller.filterMenuItems
                    .map((item) => DropdownMenuItem<AppBasicFilterItem>(
                          value: item,
                          child: Text(item.value!),
                        ))
                    .toList(),
                onChanged: (item) {
                  //print(item);
                  controller.updateSelectedFilter(item!);
                },
              ),
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month_outlined),)
          ],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.appWhite
                        : AppColors.appDarkGreen,
                  ),
              )
              : controller.filteredTransactions.isNotEmpty
                  ? ListView.builder(
            itemCount: controller.filteredTransactions.length,
            //shrinkWrap: true,
            //physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: AppLayout.getHeight(25),
                  right: AppLayout.getHeight(25),
                ),
                child: TransactionTile(
                  transaction: controller.filteredTransactions[index],
                ),
              );
            },
          )
                  : Container(
                      child: const Center(
                        child: Text("No transaction found."),
                      ),
                    ),
        ),
      ),
    );
  }
}
