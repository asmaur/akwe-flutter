import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/ui/pages/planning_new/new_planning_page_controller.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/reminder_period_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'edit_planning_page_controller.dart';

class EditPlanningPage extends StatelessWidget {
  const EditPlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EditPlanningPageController controller =
        Get.find<EditPlanningPageController>();

    final editPlanningFormKey = GlobalKey<FormState>();
    final locale = Get.deviceLocale;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            translation.userRoutineEditRoutinePageTitle.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.appWhite
                      : Colors.deepOrange,
              fontSize: 18,
                ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: controller.income.value
              ? AppColors.appDarkGreen
              : Colors.redAccent,
          actions: [
            TextButton(
              onPressed: () {
                if (editPlanningFormKey.currentState!.validate()) {
                  controller.updateCurrentRoutine();
                }
              },
              child: Text(translation.appSaveButtonLabel.tr, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.appWhite
                    : Colors.deepOrange,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: editPlanningFormKey,
            child: Container(
              child: Column(
                children: [
                  Gap(AppLayout.getHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        //width: 200;
                        //margin: EdgeInsets.only(right: 10);
                        child: Container(
                          margin: EdgeInsets.only(
                            left: AppLayout.getHeight(10),
                            right: AppLayout.getHeight(10),
                          ),
                          child: Obx(
                            () => RadioListTile(
                              title: Text(
                                  translation.appPerformanceIncomeLabel.tr),
                              value: PlanTypes.yes,
                              groupValue: controller.planType.value,
                              onChanged: (value) {
                                controller.updatePlanningType(value!);
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: AppLayout.getHeight(10),
                            right: AppLayout.getHeight(10),
                          ),
                          child: Obx(
                            () => RadioListTile(
                              title: Text(
                                  translation.appPerformanceExpenseLabel.tr),
                              value: PlanTypes.no,
                              groupValue: controller.planType.value,
                              //tileColor: Colors.redAccent;
                              onChanged: (value) {
                                //_controller.income.value = value!;
                                controller.updatePlanningType(value!);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Gap(AppLayout.getHeight(20)),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(AppLayout.getHeight(10)),
                        child: TextFormField(
                          controller: controller.name,
                          decoration: InputDecoration(
                            label: Text(
                              translation.appTextFieldNameLabel.tr,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          maxLength: 20,
                          maxLines: 1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return translation.appTextFieldNameEmptyLabel.tr;
                            } else if (value.trim().length < 5) {
                              return translation
                                  .appTextFieldNameTooShortLabel.tr;
                            } else if (value.length > 19) {
                              return translation
                                  .appTextFieldNameTooLongLabel.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppLayout.getHeight(10)),
                            child: Text(
                              NumberFormat.simpleCurrency(
                                      locale: locale?.languageCode)
                                  .currencySymbol,
                              style: TextStyle(
                                fontSize: AppLayout.getHeight(20),
                              ),
                            ),
                          ),
                          Container(
                            width: AppLayout.getScreenWidth() * 0.8,
                            padding: EdgeInsets.all(AppLayout.getHeight(10)),
                            child: TextFormField(
                              controller: controller.amount,
                              inputFormatters: <TextInputFormatter>[
                                CurrencyInputFormatter(
                                  thousandSeparator: ThousandSeparator.Space,
                                  mantissaLength: 2,
                                )
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText:
                                    translation.appTextFieldAmountLabel.tr,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return translation
                                      .appTextFieldAmountEmptyLabel.tr;
                                } else if (double.tryParse(
                                        value.removeAllWhitespace)! <=
                                    0) {
                                  return translation
                                      .appTextFieldAmountNullLabel.tr;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      // TextFormField();
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    //width: AppLayout.getScreenWidth() * 0.3,
                    child: DropdownButtonFormField<int>(
                      value: controller.notifyDayBefore.value,
                      //icon: Icon(Icons.arrow_downward);
                      elevation: 3,
                      onChanged: (int? value) =>
                          {controller.notifyDayBefore.value = value!},
                      decoration: InputDecoration(
                        labelText:
                            translation.appPlanningNewPlanningReminderLabel.tr,
                        labelStyle:
                            TextStyle(fontSize: AppLayout.getHeight(10)),
                      ),
                      items: controller.reminderPeriodList
                          .map<DropdownMenuItem<int>>((ReminderPeriod value) {
                        return DropdownMenuItem<int>(
                          value: value.period,
                          child: Text(
                            value.label,
                            style: TextStyle(fontSize: AppLayout.getHeight(12)),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return translation
                              .appTransactionNewTransactionDateEmptyLabel.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: AppLayout.getHeight(20),
                      left: AppLayout.getHeight(10),
                      right: AppLayout.getHeight(10),
                    ),
                    child: TextFormField(
                      controller: controller.dateInput,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.calendar_today),
                          labelText: translation
                              .appPlanningNewPlanningStartDateLabel.tr),
                      readOnly: true,
                      onTap: () async {
                        controller.chooseDate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return translation
                              .appTransactionNewTransactionDateEmptyLabel.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  Gap(AppLayout.getHeight(30)),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.start;
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                        child:
                            Text(translation.appTextFieldPaymentModeLabel.tr),
                      ),
                      Container(
                        padding: EdgeInsets.all(AppLayout.getHeight(10)),
                        child: Obx(
                          () => DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  width: AppLayout.getHeight(2),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  width: AppLayout.getHeight(2),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (newValue) {
                              controller.updatePaymentType(
                                  newValue!); //paymentType.value = newValue!;
                            },
                            value: controller.paymentType.value.key,
                            items: controller.paymentTypes
                                .map<DropdownMenuItem<int>>(
                                    (PaymentType payment) {
                              return DropdownMenuItem<int>(
                                value: payment.key,
                                child: Text(payment.value!),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return translation
                                    .appTextFieldPaymentModeEmptyLabel.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(AppLayout.getHeight(20)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                        child: Text(translation.appTextFieldAccountLabel.tr),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: AppLayout.getHeight(10),
                          right: AppLayout.getHeight(10),
                        ),
                        width: AppLayout.getScreenWidth(),
                        child: DropdownButtonFormField<String>(
                          //hint: Text("Select an account");
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                width: AppLayout.getHeight(2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: AppLayout.getHeight(2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) => value == null
                              ? translation.appTextFieldEmptyAccountLabel.tr
                              : null,
                          //dropdownColor: Colors.blueAccent;
                          value: controller.selectedAccount.value.id,
                          onChanged: (newValue) {
                            //controller.selectedAccount.value = newValue?.id;
                            controller.updateAccount(newValue!);
                          },
                          items: controller.accounts
                              .map<DropdownMenuItem<String>>((AppAccount el) {
                            return DropdownMenuItem<String>(
                              value: el.id,
                              child: Text(el.name!),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: AppLayout.getHeight(10),
                          right: AppLayout.getHeight(10),
                          top: AppLayout.getHeight(15),
                        ),
                        child: Text(translation.appTextFieldCategoryLabel.tr),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: AppLayout.getHeight(10),
                            right: AppLayout.getHeight(10)),
                        width: AppLayout.getScreenWidth(),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                width: AppLayout.getHeight(2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // filled: true;
                            // fillColor: Colors.blueAccent;
                          ),
                          validator: (value) => value == null
                              ? translation.appTextFieldEmptyCategoryLabel.tr
                              : null,
                          //dropdownColor: Colors.blueAccent;
                          value: controller.selectedCategory.value.id,
                          onChanged: (value) {
                            controller.updateCategory(value!);
                          },
                          items: controller.categories
                              .map<DropdownMenuItem<String>>((AppCategory el) {
                            return DropdownMenuItem<String>(
                              value: el.id,
                              child: Text(el.name!),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(AppLayout.getHeight(10)),
                    child: TextFormField(
                      controller: controller.description,
                      decoration: InputDecoration(
                          labelText:
                              translation.appTextFieldDescriptionLabel.tr),
                      maxLines: null,
                      maxLength: 50,
                    ),
                  ),
                  Gap(AppLayout.getHeight(30)),
                  Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
