import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:mask/mask.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'goal_deposit_page_controller.dart';

class GoalDepositPage extends StatelessWidget {
  const GoalDepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GoalDepositPageController>();
    final goalDepositFormKey = GlobalKey<FormState>();
    final locale = Get.deviceLocale;

    final currency = NumberFormat.currency(
      locale: locale?.languageCode,
      symbol: NumberFormat.simpleCurrency(locale: locale?.languageCode)
          .currencySymbol,
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(translation.appGoalDepositTitle.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24),),
      ),
      body: Obx(
        () => Column(
          children: [
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    color: controller.currentGoal.value.color?.color,
                    borderRadius: BorderRadius.circular(50)),
                width: 35,
                height: 35,
                child: Icon(
                  controller.currentGoal.value.icon?.icon,
                  color: AppColors.appWhite,
                  size: 24,
                ),
              ),
              title: Text(
                controller.currentGoal.value.name!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 18),
              ),
              subtitle: Text(
                DateFormat.yMMMd(locale?.languageCode).format(controller.currentGoal.value.deadlineDate!),
              ),
              //trailing: Text("balance: ${currency.format(_controller.currentGoal.value.balance)}"),
            ),
            Center(
              child: Text(
                  "${translation.appGoalCurrentBalanceText.tr} ${currency.format(controller.currentGoal.value.balance)}"),
            ),
            const Divider(),
            ReactiveForm(
              // key: goalDepositFormKey,
              formGroup: controller.form,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: AppLayout.getHeight(10),
                        horizontal: AppLayout.getHeight(20)),
                    child: ReactiveTextField(
                      formControlName: "amount",
                      decoration: InputDecoration(
                        label: Text(translation.appGoalDepositAmountLabel.tr),
                        hintText: translation.appGoalDepositAmountLabel.tr,
                        //translation.userAccountAccountBalanceText.tr,
                        //border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: AppLayout.getHeight(30)),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        Mask.money(decimalLenght: 2, decimal: '', fracion: '.', moneySymbol: ''),
                        // CurrencyInputFormatter(
                        //   thousandSeparator: ThousandSeparator.Space,
                        //   mantissaLength: 2,
                        // )
                      ],
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return translation
                        //         .appTextFieldAmountEmptyLabel.tr;
                        //   } else if (double.tryParse(
                        //       value.removeAllWhitespace)! <=
                        //       0) {
                        //     return translation
                        //         .appTextFieldAmountNullLabel.tr;
                        //   }
                        //   return null;
                        // }
                    ),
                  ),
                  Gap(AppLayout.getHeight(20)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: AppLayout.getHeight(15),
                        ),
                        child: Text(translation.appTextFieldAccountLabel.tr),
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          AppLayout.getHeight(10),
                        ),
                        //width: AppLayout.getScreenWidth() * 0.45,
                        child: Obx(() => Container(
                          padding: EdgeInsets.all(AppLayout.getHeight(10)),
                          //width: AppLayout.getScreenWidth() * 0.45,
                          child: ReactiveDropdownField<String>(
                            formControlName: 'account_id',
                            hint: Text(translation.appTextFieldAccountLabel.tr),
                            // onChanged: (newValue) {
                            //   controller.updateAccount(newValue.value!);
                            // },
                            items: controller.accounts
                                .map<DropdownMenuItem<String>>((AppAccount el) {
                              return DropdownMenuItem<String>(
                                value: el.id,
                                child: Text(el.name!),
                              );
                            }).toList(),
                            validationMessages: {
                              ValidationMessage.required: (_) =>
                              translation.appTextFieldEmptyAccountLabel.tr,
                            },
                          ),
                        ),)
                        // Obx(
                        //   () => DropdownButtonFormField<int>(
                        //     //hint: Text("Select an account");
                        //     decoration: InputDecoration(
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //           color: Theme.of(context).brightness ==
                        //                   Brightness.light
                        //               ? Colors.black
                        //               : Colors.white,
                        //           width: 2,
                        //         ),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       border: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //           width: AppLayout.getHeight(2),
                        //         ),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       // filled: true;
                        //       // fillColor: Colors.blueAccent;
                        //     ),
                        //     validator: (value) => value == null
                        //         ? translation.appTextFieldEmptyAccountLabel.tr
                        //         : null,
                        //     value: controller.selectedAccount.value,
                        //     onChanged: (newValue) {
                        //       controller.updateAccount(newValue!);
                        //     },
                        //     items: controller.accounts
                        //         .map<DropdownMenuItem<int>>((AppAccount el) {
                        //       return DropdownMenuItem<int>(
                        //         value: el.id,
                        //         child: Text(el.name!),
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: AppLayout.getScreenWidth() * 0.7,
              padding: EdgeInsets.only(
                top: AppLayout.getHeight(20),
                bottom: AppLayout.getHeight(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      // if (goalDepositFormKey.currentState!.validate()) {
                      //   controller.addGoalDeposit();
                      // }
                      controller.addGoalDeposit();
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.appRed,
                        side: const BorderSide(color: Colors.transparent)),
                    child: Text(
                      translation.appSaveButtonLabel.tr,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.appWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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
    );
  }
}
