import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mask/mask.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'new_budget_page_controller.dart';

class NewBudgetPage extends StatelessWidget {
  const NewBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewBudgetPageController());
    final budgetFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.userNewBudgetTitleText.tr,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 18, fontWeight: FontWeight.w100),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       if (budgetFormKey.currentState!.validate()) {
        //         controller.createBudget();
        //       }
        //     },
        //     child: Text(translation.userBudgetCreateText.tr),
        //   ),
        // ],
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(AppLayout.getHeight(10)),
        child: ReactiveForm(
          formGroup: controller.form,
          child: Column(
            children: [
              Gap(AppLayout.getHeight(10)),
              ReactiveTextField(
                // controller: controller.budgetBalance,
                formControlName: "initial_balance",
                decoration: InputDecoration(
                  hintText: translation.userBudgetBalanceText.tr,
                  labelText: translation.userBudgetBalanceText.tr,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.appDarkGreen
                          : AppColors.appWhite,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.appDarkGreen
                          : AppColors.appWhite,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: AppLayout.getHeight(30)),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                //initialValue: "0";
                inputFormatters: <TextInputFormatter>[
                  Mask.money(decimalLenght: 2, decimal: '', fracion: '.', moneySymbol: ''),
                ],
                validationMessages: {
                  ValidationMessage.required: (_) => translation.userBudgetEmptyErrorMessage.tr,
                  ValidationMessage.min: (_) => translation.userBudgetTooLowErrorMessage.tr,
                },
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return translation.userBudgetEmptyErrorMessage.tr;
                //   } else if (double.parse(value.removeAllWhitespace) < 100) {
                //     return translation.userBudgetTooLowErrorMessage.tr;
                //   }
                //   return null;
                // },
              ),
              Gap(AppLayout.getHeight(15)),

              ReactiveSwitchListTile(
                formControlName: "insert_balance",
                // leading: const Icon(Icons.info_outline_rounded),
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: const Icon(Icons.info_outline_rounded),
                    ),
                    Container(
                      width: AppLayout.getWidth(200),
                      child: Text(
                        translation.userAddCurrentBudgetBalanceText.tr,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),

              // Obx(
              //   () => ListTile(
              //     leading: const Icon(Icons.info_outline_rounded),
              //     title: Text(
              //       translation.userAddCurrentBudgetBalanceText.tr,
              //     ),
              //     enabled: true,
              //     onTap: () => controller.toggle(),
              //     //enableFeedback: true;
              //     trailing: Switch(
              //       onChanged: (value) => controller.toggle(),
              //       value: controller.insertCurrentBalance.value,
              //     ),
              //   ),
              // ),
              Gap(AppLayout.getHeight(20)),

              Container(
                child: Row(
                  children: [
                    Flexible(
                      //flex: 1;
                      child: Column(
                        children: [
                          Text(
                            translation.userBudgetDescriptionText.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepOrange,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gap(AppLayout.getHeight(20)),
              Container(
                child: Flexible(
                  //flex: 0;
                  child: Column(
                    children: [
                      Text(
                        translation.userBudgetInfoText.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrange,
                            ),
                      ),
                      
                      Gap(AppLayout.getHeight(40)),
                      
                      Center(
                        child: OutlinedButton(
                          onPressed: () {
                            // if (budgetFormKey.currentState!.validate()) {
                            //   controller.createBudget();
                            // }
                            controller.createBudget();
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.appRed,
                            side: const BorderSide(color: Colors.transparent),
                          ),
                          child: Text(
                            translation.userBudgetCreateText.tr,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: AppColors.appWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //Center(child: OutlinedButton(onPressed: (){}, child: Text("Atualizar"),),)
            ],
          ),
        ),
      ),
    );
  }
}
