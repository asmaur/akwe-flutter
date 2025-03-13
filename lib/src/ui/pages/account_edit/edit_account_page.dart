import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/banking.dart';
import 'package:akwe/src/ui/shared/color_tile.dart';
import 'package:akwe/src/utils/instituitions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';
import 'edit_account_page_controller.dart';

class EditAccountPage extends StatelessWidget {
  const EditAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final editAccountFormKey = GlobalKey<FormState>();
    final EditAccountPageController controller = Get.find<EditAccountPageController>();


    return Scaffold(
      appBar: AppBar(
        title: Text(translation.userAccountEditTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),),
      ),
      body: SingleChildScrollView(
        child: ReactiveForm(
          formGroup: controller.form,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: AppLayout.getHeight(20)),
                Column(
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: AppLayout.getHeight(10),
                          horizontal: AppLayout.getHeight(20)),
                      child: ReactiveTextField(
                        // controller: controller.accountBalance,
                        formControlName: "balance",
                        decoration: InputDecoration(
                          hintText: translation.userAccountAccountBalanceText.tr,
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: AppLayout.getHeight(30)),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          CurrencyInputFormatter(
                            thousandSeparator: ThousandSeparator.Space,
                            mantissaLength: 2,
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      width: AppLayout.getScreenWidth() * 0.8,
                      child: ReactiveTextField(
                        // controller: controller.name,
                        formControlName: "name",
                        decoration: InputDecoration(
                          label: Text(
                            translation.appTextFieldNameLabel.tr,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        maxLength: 20,
                          validationMessages: {
                            ValidationMessage.required: (_) => translation.appTextFieldNameEmptyLabel.tr,
                            ValidationMessage.minLength: (_) => translation.appTextFieldNameTooShortLabel.tr,
                            ValidationMessage.maxLength: (_) => translation.appTextFieldNameTooLongLabel.tr,
                          },
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return translation.appTextFieldNameEmptyLabel.tr;
                        //   } else if (value.trim().length < 5) {
                        //     return translation.appTextFieldNameTooShortLabel.tr;
                        //   } else if (value.length > 19) {
                        //     return translation.appTextFieldNameTooLongLabel.tr;
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                    Gap(AppLayout.getHeight(10)),


                    Obx(
                          () => ListTile(
                        leading: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            controller.selectedBank.value.logo!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        title: Text(
                          controller.selectedBank.value.name!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 20),
                        ),
                        subtitle: Text(
                          translation.appFinanceInstitutionLabel.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 14),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        onTap: () => showModalBottomSheet(
                          isScrollControlled: true,
                          showDragHandle: true,
                          context: context,
                          builder: (context) =>
                              financialInstitutionSheet(controller),
                        ),
                      ),
                    ),

                    const Divider(),


                    Obx(
                          () => ListTile(
                      leading: controller.accountType.value.icon, //const Icon(Icons.wallet_outlined),
                      title: Text(
                              controller.accountType.value.name == ""
                              ? translation.userAccountAccountTypeText.tr
                              : controller.accountType.value.name,
                        ),

                      trailing: const Icon(Icons.arrow_forward_ios),
                      enabled: true,
                      enableFeedback: true,
                      onTap: () {
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: AppLayout.getScreenHeight() * .5,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: AppLayout.getHeight(10),
                                        bottom: AppLayout.getHeight(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          translation.userAccountAccountTypeText.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: AppColors.appBlue,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: controller.accountTypes.length,
                                        itemBuilder: (_, index) {
                                          return Obx(() => RadioListTile(
                                            value: controller.accountTypes[index].key,
                                            groupValue:
                                            controller.accountType.value.key,
                                            title:
                                            Text(controller.accountTypes[index].name),
                                            controlAffinity:
                                            ListTileControlAffinity
                                                .platform,
                                            secondary: controller.accountTypes[index].icon,
                                            onChanged: (value) {
                                              debugPrint("$value");
                                              controller
                                                  .updateAccountType(value);
                                              // _controller.updateAccountTypeValue(
                                              //     _controller.accountTypes[index].value);
                                            },
                                          ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),),

                    const Divider(),

                    Obx(
                          () => ListTile(
                        leading: const Icon(Icons.palette_outlined),
                        title: Text(translation.appSelectColorLabel.tr),
                        trailing: ColorTile(controller.selectedColor.value),
                        enabled: true,
                        enableFeedback: true,
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: AppLayout.getScreenHeight() * .5,
                                padding: EdgeInsets.all(AppLayout.getHeight(16)),
                                //color: Colors.white,
                                decoration: const BoxDecoration(
                                  color: AppColors.appMidGray,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.app_color_list.length,
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          right: AppLayout.getHeight(8)),
                                      child: Column(
                                        children: <Widget>[
                                          //ColorTile();
                                          Obx(
                                                () => FloatingActionButton(
                                              mini: true,
                                              onPressed: () {
                                                controller
                                                    .updateSelectedColor(index);
                                                Get.back();
                                              },
                                              //child: Icon(Icons.done, color: index == controller.selectedIndex.value ? Colors.white:colorsData.elementAt(index),size: 28),
                                              //child: Icon(Icons.done; colo appDataColors.elementAt(index); size: 20);
                                              backgroundColor:
                                              controller.app_color_list.elementAt(index).color,
                                              elevation: 0.0,
                                              heroTag: null,
                                              child:
                                              controller.selectedIndex.value ==
                                                  index
                                                  ? const Icon(Icons.done,
                                                  color: Colors.white)
                                                  : Container(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                ),

                                // container end
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const Divider(),



                    Container(
                      child: ReactiveSwitchListTile(
                        formControlName: "is_fund",
                        title: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: const Icon(Icons.info_outline_rounded),
                            ),
                            Text(
                              translation.userAccountIsFund.tr,
                            ),
                          ],
                        ),
                      ),

                      // Obx(
                      //   () => ListTile(
                      //     leading: const Icon(Icons.info_outline_rounded),
                      //     title: Text(
                      //       translation.userCategoryIsIncomeLabel.tr,
                      //     ),
                      //     enabled: true,
                      //     onTap: () => controller.toggle(),
                      //     trailing: Switch(
                      //       onChanged: (value) => controller.toggle(),
                      //       value: controller.isFund.value,
                      //     ),
                      //   ),
                      // ),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.mic_outlined),
                      title: ReactiveTextField(
                        // controller: controller.description,
                        formControlName: "description",
                        decoration: InputDecoration(
                          labelText: translation.userAccountDescription.tr,
                        ),
                        minLines: 1,
                        maxLines: null,
                        maxLength: 50,
                      ),
                    ),

                    //Divider(),

                    //Gap(10),
                    // Container(
                    //   width: AppLayout.getScreenWidth() * 0.8,
                    //   child: TextFormField(
                    //     controller: _controller.description,
                    //     decoration: InputDecoration(
                    //         labelText:
                    //             translation.appTextFieldDescriptionLabel.tr),
                    //     maxLength: 50,
                    //     maxLines: null,
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  width: AppLayout.getScreenWidth() * 0.7,
                  padding: EdgeInsets.only(
                      top: AppLayout.getHeight(20),
                      bottom: AppLayout.getHeight(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.appRed)),
                        child: Text(
                          translation.appCancelButtonLabel.tr,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: AppColors.appRed),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (editAccountFormKey.currentState!.validate()) {
                            controller.updateAccount();
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.appRed,
                          side: const BorderSide(color: Colors.transparent),
                        ),
                        child: Text(
                          translation.appSaveButtonLabel.tr,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: AppColors.appWhite, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        // style: ButtonStyle(
                        //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        //         (Set<MaterialState> states) {
                        //       if (states.contains(MaterialState.pressed)) {
                        //         return AppColors.appRed;
                        //       }
                        //       return AppColors.appRed;
                        //     },
                        //   ),
                        //   shape: MaterialStateProperty.all(
                        //     RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30),
                        //       side: const BorderSide(color: AppColors.appRed, width: 0)
                        //     )
                        //   )
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  // loadAccountColor(BuildContext context) {
  //   final controller = Get.find<EditAccountController>();
  //
  //   return showModalBottomSheet<dynamic>(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (BuildContext bc) {
  //       return Container(
  //         height: AppLayout.getScreenHeight() * .5,
  //         padding: EdgeInsets.all(AppLayout.getHeight(16)),
  //         //color: Colors.white,
  //         decoration: BoxDecoration(
  //           color: AppColors.appMidGray,
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(30),
  //             topRight: Radius.circular(30),
  //           ),
  //         ),
  //         child: GridView.builder(
  //           scrollDirection: Axis.vertical,
  //           itemCount: appColors.length,
  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 5,
  //             childAspectRatio: 1,
  //           ),
  //           itemBuilder: (BuildContext context, int index) {
  //             return Padding(
  //               padding: EdgeInsets.only(right: AppLayout.getHeight(8)),
  //               child: Column(
  //                 children: <Widget>[
  //                   //ColorTile();
  //                   FloatingActionButton(
  //                     mini: true,
  //                     onPressed: () {
  //                       controller.updateSelectedColor(index);
  //                     },
  //                     //child: Icon(Icons.done, color: index == controller.selectedIndex.value ? Colors.white:colorsData.elementAt(index),size: 28),
  //                     //child: Icon(Icons.done; colo appDataColors.elementAt(index); size: 20);
  //                     backgroundColor: appDataColors.elementAt(index),
  //                     elevation: 0.0,
  //                     heroTag: null,
  //                     child: Icon(Icons.done, color: Colors.white),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //           shrinkWrap: true,
  //         ),
  //
  //         // container end
  //       );
  //     },
  //   );
  // }

  financialInstitutionSheet(EditAccountPageController editController) {
    final banks = getBankInstitution();
    return DraggableScrollableSheet(
        initialChildSize: .5,
        minChildSize: .3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, controller) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  ListView.separated(
                    controller: controller,
                    itemCount: banks.length,
                    itemBuilder: (context, index) {
                      final bank = banks[index];
                      return buildBankTile(bank, editController);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      if (index == banks.length - 1) {
                        return const Divider(height: 1);
                      }
                      return const Divider();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildBankTile(Bank bank, EditAccountPageController controller) {
    //final controller = Get.put(NewAccountController());
    return ListTile(
      visualDensity: const VisualDensity(vertical: .2),
      contentPadding: const EdgeInsets.only(top: 0.5, bottom: 0.5),
      leading: SizedBox(
        width: 40,
        height: 40,
        child: Image.asset(
          bank.logo!,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(bank.name!),
      onTap: () {
        controller.updateSelectedBank(bank);
        Get.back();
      },
    );
  }


}
