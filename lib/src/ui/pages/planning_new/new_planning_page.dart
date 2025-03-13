import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
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

import 'new_planning_page_controller.dart';

class NewPlanningPage extends StatelessWidget {
  const NewPlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewPlanningController controller = Get.put(NewPlanningController());
    final reminderPeriodList = getReminderPeriod();

    final newPlanningFormKey = GlobalKey<FormState>();
    //final paymentTypes = getPaymentTypeList();
    final locale = Get.deviceLocale;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            translation.appPlanningNewPlanningTitle.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white, fontSize: 18,),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: controller.income.value
              ? AppColors.appDarkGreen
              : Colors.redAccent,
          actions: [
            IconButton(
              onPressed: () => {
                showModalBottomSheet<dynamic>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        height: AppLayout.getScreenHeight() * .7,
                      );
                    })
              },
              icon: const Icon(Icons.info_outline, color: Colors.white,),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: newPlanningFormKey,
                child: Container(
                  child: Column(
                    children: [
                      Gap(AppLayout.getHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  //left: AppLayout.getHeight(4),
                                  //right: AppLayout.getHeight(8)
                                ),
                              child: Obx(
                                () => RadioListTile(
                                  title: Text(translation
                                      .appTransactionNewTransactionTypeIncome.tr),
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
                              margin: const EdgeInsets.only(
                                //left: AppLayout.getHeight(10),
                                //right: AppLayout.getHeight(10),
                              ),
                              child: Obx(
                                () => RadioListTile(
                                  title: Text(translation
                                      .appTransactionNewTransactionTypeExpense.tr),
                                  value: PlanTypes.no,
                                  groupValue: controller.planType.value,
                                  onChanged: (value) {
                                    controller.updatePlanningType(value!);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      Gap(AppLayout.getHeight(1)),

                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10), //EdgeInsets.all(AppLayout.getHeight(5)),
                            child: TextFormField(
                              controller: controller.name,
                              decoration: InputDecoration(
                                labelText: translation.appTextFieldNameLabel.tr,
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
                                    labelText: translation.appTextFieldAmountLabel.tr,
                                        helperText: translation.userRoutineAmountHelperText.tr,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: AppLayout.getHeight(10)),
                            width: AppLayout.getScreenWidth() * 0.35,
                            child: TextFormField(
                              controller: controller.frequency,
                              decoration: InputDecoration(
                                labelText: translation
                                    .appPlanningNewPlanningRepeatTimeLabel.tr,
                                labelStyle:
                                    TextStyle(fontSize: AppLayout.getHeight(10)),
                              ),
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: false),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[1-9]{1,2}'))
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return translation
                                      .appTextFieldNumberInvalidLabel.tr;
                                } else if (int.tryParse(value.trim())! == 0) {
                                  return translation
                                      .appTextFieldNumberInvalidLabel.tr;
                                } else if (int.tryParse(value.trim())! > 99) {
                                  return translation
                                      .appTextFieldNumberInvalidLabel.tr;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: AppLayout.getScreenWidth() * 0.3,
                            child: TextFormField(
                              controller: controller.repeatEvery,
                              decoration: InputDecoration(
                                labelText:
                                    translation.appPlanningNewPlanningEveryLabel.tr,
                                labelStyle:
                                    TextStyle(fontSize: AppLayout.getHeight(10)),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]{1,2}'))
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return translation
                                      .appTextFieldNumberInvalidLabel.tr;
                                } else if (int.tryParse(value.trim())! == 0) {
                                  return translation
                                      .appTextFieldNumberInvalidLabel.tr;
                                } else if (int.tryParse(value.trim())! > 99) {
                                  return translation
                                      .appTextFieldNumberInvalidLabel.tr;
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              right: AppLayout.getHeight(8),
                            ),
                            width: AppLayout.getScreenWidth() * 0.3,
                            child: DropdownButtonFormField<int>(
                              value: controller.notifyDayBefore.value,
                              elevation: 3,
                              onChanged: (int? value) =>
                                  {controller.notifyDayBefore.value = value!},
                              decoration: InputDecoration(
                                labelText: translation
                                    .appPlanningNewPlanningReminderLabel.tr,
                                labelStyle:
                                    TextStyle(fontSize: AppLayout.getHeight(10)),
                              ),
                              items: reminderPeriodList.map<DropdownMenuItem<int>>(
                                  (ReminderPeriod value) {
                                return DropdownMenuItem<int>(
                                  value: value.period,
                                  child: Text(
                                    value.label,
                                    style: TextStyle(
                                        fontSize: AppLayout.getHeight(12),),
                                  ),
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return "";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      Column(
                        children: [
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
                                  //icon of text field
                                  labelText: translation
                                      .appPlanningNewPlanningStartDateLabel.tr),
                              readOnly: true,
                              onTap: () async {
                                controller.chooseDate();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return translation
                                      .appTransactionNewTransactionDateEmptyLabel
                                      .tr;
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
                                padding:
                                    EdgeInsets.only(left: AppLayout.getHeight(15)),
                                child: Text(
                                    translation.appTextFieldPaymentModeLabel.tr),
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
                                          width: 2,
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
                                    onChanged: (newValue) {
                                      controller.updatePaymentType(newValue!); //paymentType.value = newValue!;
                                    },
                                    value: controller.paymentType.value.key,
                                    items: controller.paymentTypes.map<DropdownMenuItem<int>>(
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
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: AppLayout.getHeight(15),
                                    ),
                                    child: Text(
                                        translation.appTextFieldAccountLabel.tr),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(
                                        AppLayout.getHeight(10),),
                                    //width: AppLayout.getScreenWidth() * 0.45,
                                    child: Obx(
                                      () => DropdownButtonFormField<String>(
                                        //hint: Text("Select an account");
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context).brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: AppLayout.getHeight(2),
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          // filled: true;
                                          // fillColor: Colors.blueAccent;
                                        ),
                                        validator: (value) => value == null
                                            ? translation
                                                .appTextFieldEmptyAccountLabel.tr
                                            : null,
                                        value: controller.selectedAccount.value.id,
                                        onChanged: (newValue) {
                                          controller.updateAccount(newValue!);
                                        },
                                        items: controller.accounts
                                            .map<DropdownMenuItem<String>>(
                                                (AppAccount el) {
                                          return DropdownMenuItem<String>(
                                            value: el.id,
                                            child: Text(el.name!),
                                          );
                                        }).toList(),
                                      ),
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
                                    ),
                                    child: Text(
                                        translation.appTextFieldCategoryLabel.tr,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(
                                        AppLayout.getHeight(10),),
                                    //width: AppLayout.getScreenWidth() * 0.45,
                                    child: Obx(
                                      () => DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context).brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                AppLayout.getHeight(10)),
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
                                        ),
                                        validator: (value) => value == null
                                            ? translation
                                                .appTextFieldEmptyCategoryLabel.tr
                                            : null,
                                        value: controller.selectedCategory.value.id,
                                        onChanged: (value) {
                                          controller.updateCategory(value!);
                                        },
                                        items: controller.categories
                                            .map<DropdownMenuItem<String>>(
                                                (AppCategory el) {
                                          return DropdownMenuItem<String>(
                                            value: el.id,
                                            child: Text(el.name!),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
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
                          // TextFormField(),
                        ],
                      ),

                      Gap(AppLayout.getHeight(30)),

                      Container(),
                      SizedBox(
                        width: AppLayout.getWidth(150),
                        child: OutlinedButton(
                          child: Text(translation.appSaveButtonLabel.tr),
                          onPressed: () {
                            if (newPlanningFormKey.currentState!.validate()) {
                              controller.createNewPlanning();
                            }
                          },
                        ),
                      ),

                      // Container(
                      //   child: SfDateRangePicker(
                      //     //onSelectionChanged: _onSelectionChanged;
                      //     selectionMode: DateRangePickerSelectionMode.range;
                      //   );
                      // );
                    ],
                  ),
                ),
              ),

              const Gap(20),

              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _showPlanningInfo() {
  return Container();
}
