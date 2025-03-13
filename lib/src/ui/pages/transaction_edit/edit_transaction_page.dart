import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:mask/mask/mask.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'edit_transaction_page_controller.dart';


class EditTransactionPage extends StatelessWidget {
  const EditTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {

    final EditTransactionPageController controller =
    Get.find<EditTransactionPageController>();
    final editTransactionFormKey = GlobalKey<FormState>();
    final locale = Get.deviceLocale;


    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(translation.userTransactionEditTransactionText.tr, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white, fontSize: 18,),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor:
        controller.income.value ? AppColors.appDarkGreen : Colors.red,
      ),
      body: SingleChildScrollView(
        child: ReactiveForm(
          // key: editTransactionFormKey,
          formGroup: controller.form,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppLayout.getHeight(10),
                ),
                child: SizedBox(
                  child: ReactiveTextField(
                    // controller: controller.name,
                    formControlName: "name",
                    maxLength: 50,
                    decoration: InputDecoration(
                      label: Text(
                        translation.appTextFieldNameLabel.tr,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return translation.appTextFieldNameEmptyLabel.tr;
                    //   } else if (value.trim().length < 5) {
                    //     return translation.appTextFieldNameTooShortLabel.tr;
                    //   } else if (value.length > 50) {
                    //     return translation.appTextFieldNameTooLongLabel.tr;
                    //   }
                    //   return null;
                    // },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(
                  AppLayout.getHeight(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.income.value
                        ? Text(
                      "+",
                      style:
                      TextStyle(fontSize: AppLayout.getHeight(50)),
                    )
                        : Text(
                      "-",
                      style:
                      TextStyle(fontSize: AppLayout.getHeight(50)),
                    ),
                    Container(
                      child: Text(
                        NumberFormat.simpleCurrency(
                            locale: locale?.languageCode)
                            .currencySymbol,
                        style: TextStyle(
                          fontSize: AppLayout.getHeight(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppLayout.getHeight(5),
                    ),
                    SizedBox(
                      width: AppLayout.getScreenWidth() * 0.6,
                      child: ReactiveTextField(
                        // controller: controller.amount,
                        formControlName: "total_payed",
                        decoration: InputDecoration(
                          labelText: translation.appTextFieldAmountLabel.tr,
                        ),
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
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
                        //     return translation.appTextFieldAmountNullLabel.tr;
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ],
                ),
              ),

              // Container(
              //   padding: EdgeInsets.only(
              //     top: AppLayout.getHeight(5),
              //     left: AppLayout.getHeight(10),
              //     right: AppLayout.getHeight(10),
              //   ),
              //   child: TextFormField(
              //     controller: controller.dateInput,
              //     decoration: InputDecoration(
              //         icon: const Icon(Icons.calendar_today),
              //         //icon of text field
              //         labelText: translation
              //             .appTransactionNewTransactionDateLabel.tr),
              //     readOnly: true,
              //     onTap: () async {
              //       controller.chooseDate();
              //     },
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return translation
              //             .appTransactionNewTransactionDateEmptyLabel.tr;
              //       }
              //     },
              //   ),
              // ),
              // Gap(AppLayout.getHeight(10)),

              Container(
                margin:
                EdgeInsets.symmetric(horizontal: AppLayout.getHeight(20)),
                child: SizedBox(
                  child: ReactiveTextField(
                    // controller: controller.description,
                    formControlName: "description",
                    decoration: InputDecoration(
                        label: Text(
                          translation.appTextFieldDescriptionLabel.tr,
                        ),
                        fillColor: Colors.cyanAccent),
                    maxLines: null,
                    maxLength: 50,
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(10)),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                    child: Text(translation.appTextFieldPaymentModeLabel.tr),
                  ),
                  Container(
                    padding: EdgeInsets.all(AppLayout.getHeight(10)),
                    child: ReactiveDropdownField<int>(
                      formControlName: 'payment_method',
                      hint: Text(translation.appTextFieldPaymentModeLabel.tr),
                      // onChanged: (newValue) {
                      //   controller.updatePaymentType(
                      //       newValue.value!); //paymentCode.value = newValue!;
                      // },
                      //     value: controller.paymentType.value.key,
                      items: paymentTypes.map<DropdownMenuItem<int>>((PaymentType payment) {
                        return DropdownMenuItem<int>(
                          value: payment.key,
                          child: Text(payment.value!),
                        );
                      }).toList(),
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                        translation.appTextFieldPaymentModeEmptyLabel.tr,
                      },
                    ),
                    // Obx(
                    //       () => DropdownButtonFormField<int>(
                    //     decoration: InputDecoration(
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Theme.of(context).brightness ==
                    //               Brightness.light
                    //               ? Colors.black
                    //               : Colors.white,
                    //           width: 2,
                    //         ),
                    //         borderRadius: BorderRadius.circular(AppLayout.getHeight(10)),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Theme.of(context).brightness ==
                    //               Brightness.light
                    //               ? Colors.black
                    //               : Colors.white,
                    //           width: 2,
                    //         ),
                    //         borderRadius: BorderRadius.circular(AppLayout.getHeight(10)),
                    //       ),
                    //     ),
                    //     onChanged: (newValue) {
                    //       //_controller.paymentCode.value = newValue!;
                    //       controller.updatePaymentType(newValue!);
                    //     },
                    //     value: controller.paymentType.value.key,
                    //     items: controller.paymentTypes.map<DropdownMenuItem<int>>(
                    //             (PaymentType payment) {
                    //           return DropdownMenuItem<int>(
                    //             value: payment.key,
                    //             child: Text(payment.value!),
                    //           );
                    //         }).toList(),
                    //     validator: (value) {
                    //       if (value == null) {
                    //         return translation
                    //             .appTextFieldPaymentModeEmptyLabel.tr;
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                  ),
                ],
              ),

              Gap(AppLayout.getHeight(10)),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: AppLayout.getHeight(15),
                    ),
                    child: Text(translation.appTextFieldAccountLabel.tr),
                  ),

                  Obx(() => Container(
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
                  ),),

                  // Container(
                  //   padding: EdgeInsets.all(AppLayout.getHeight(10)),
                  //   //width: AppLayout.getScreenWidth() * 0.45,
                  //   child: Obx(
                  //         () => DropdownButtonFormField<String>(
                  //       //hint: Text("Select an account");
                  //       decoration: InputDecoration(
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Theme.of(context).brightness ==
                  //                 Brightness.light
                  //                 ? Colors.black
                  //                 : Colors.white,
                  //             width: 2,
                  //           ),
                  //           borderRadius: BorderRadius.circular(
                  //               AppLayout.getHeight(10)),
                  //         ),
                  //         border: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             //color: Colors.blue;
                  //             width: AppLayout.getHeight(2),
                  //           ),
                  //           borderRadius: BorderRadius.circular(
                  //               AppLayout.getHeight(10)),
                  //         ),
                  //         // filled: true;
                  //         // fillColor: Colors.blueAccent;
                  //       ),
                  //       validator: (value) => value == null
                  //           ? translation.appTextFieldEmptyAccountLabel.tr
                  //           : null,
                  //       //dropdownColor: Colors.blueAccent;
                  //       value: controller.selectedAccount.value.id,
                  //       onChanged: (newValue) {
                  //         //controller.selectedAccount.value = newValue?.id;
                  //         controller.updateAccount(newValue!);
                  //       },
                  //       items: controller.accounts
                  //           .map<DropdownMenuItem<String>>((AppAccount el) {
                  //         return DropdownMenuItem<String>(
                  //           value: el.id,
                  //           child: Text(el.name!),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              Gap(AppLayout.getHeight(10)),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: AppLayout.getHeight(10)),
                    child: Text(translation.appTextFieldCategoryLabel.tr),
                  ),

                  Obx(() =>
                      Container(
                        padding: EdgeInsets.all(AppLayout.getHeight(10)),
                        //width: AppLayout.getScreenWidth() * 0.45,
                        child: ReactiveDropdownField<String>(
                          formControlName: 'category_id',
                          hint: Text(translation.appTextFieldCategoryLabel.tr),
                          items: controller.categories
                              .map<DropdownMenuItem<String>>((AppCategory el) {
                            return DropdownMenuItem<String>(
                              value: el.id,
                              child: Text(el.name!),
                            );
                          }).toList(),
                          // onChanged: (value) {
                          //   controller.updateCategory(value.value!);
                          // },
                          validationMessages: {
                            ValidationMessage.required: (_) =>
                            translation.appTextFieldEmptyCategoryLabel.tr,
                          },
                        ),
                      ),),

                  // Container(
                  //   padding: EdgeInsets.all(AppLayout.getHeight(10)),
                  //   //width: AppLayout.getScreenWidth() * 0.45,
                  //   child: Obx(
                  //         () => DropdownButtonFormField<String>(
                  //       decoration: InputDecoration(
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Theme.of(context).brightness ==
                  //                 Brightness.light
                  //                 ? Colors.black
                  //                 : Colors.white,
                  //             width: 2,
                  //           ),
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         border: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Theme.of(context).brightness ==
                  //                 Brightness.light
                  //                 ? Colors.black
                  //                 : Colors.white,
                  //             width: 2,
                  //           ),
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         // filled: true;
                  //         // fillColor: Colors.blueAccent;
                  //       ),
                  //       validator: (value) => value == null
                  //           ? translation.appTextFieldEmptyCategoryLabel.tr
                  //           : null,
                  //       //dropdownColor: Colors.blueAccent;
                  //       value: controller.selectedCategory.value.id,
                  //       onChanged: (value) {
                  //         controller.updateCategory(value!);
                  //       },
                  //       items: controller.categories
                  //           .map<DropdownMenuItem<String>>((AppCategory el) {
                  //         return DropdownMenuItem<String>(
                  //           value: el.id,
                  //           child: Text(el.name!),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              Container(
                width: AppLayout.getScreenWidth() * 0.7,
                padding: EdgeInsets.only(top: AppLayout.getHeight(20), bottom: AppLayout.getHeight(20),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.appRed),),
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
                        // if(editTransactionFormKey.currentState!.validate()){
                        //   controller.updateTransaction();
                        // }
                        controller.updateTransaction();
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.appRed,
                          side: const BorderSide(color: Colors.transparent),),
                      child: Text(translation.userAccountNewAccountSave.tr, style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: AppColors.appWhite, fontSize: 16, fontWeight: FontWeight.w600,),),

                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    ),);
  }
}
