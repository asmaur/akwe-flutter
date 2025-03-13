import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:akwe/src/utils/payment_type_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sizer/sizer.dart';
import 'new_transaction_page_controller.dart';

class NewTransactionPage extends StatelessWidget {
  const NewTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewTransactionPageController controller =
        Get.find<NewTransactionPageController>();
    // Get.put(NewTransactionController());

    final newTransactionFormKey = GlobalKey<FormState>();
    final paymentTypes = getPaymentTypeList();
    final locale = Get.deviceLocale;

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () => {
        //     Navigator.of(context).pop()
        //   };
        //   icon: Icon(Icons.close; color: AppColors.appWhite; size: 30;);
        // );
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor:
            controller.income.value ? AppColors.appDarkGreen : Colors.red,
        title: Obx(
          () => controller.income.value
              ? Text(
                  translation.appTransactionNewTransactionTypeIncome.tr,
                  style: const TextStyle(
                      color: AppColors.appWhite, fontWeight: FontWeight.w600),
                )
              : Text(
                  translation.appTransactionNewTransactionTypeExpense.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 18),
                ),
        ),
        elevation: 5,
        actions: [
          TextButton(
            onPressed: () {
              controller.createNewTransaction();
              // if (newTransactionFormKey.currentState!.validate()) {
              //   controller.createNewTransaction();
              // }
            },
            child: Text(
              translation.appSaveButtonLabel.tr,
              //translation.appTransactionNewTransactionCreateButtonText.tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ReactiveForm(
            // key: newTransactionFormKey,
            formGroup: controller.form,
            child: Column(
              children: [
                Container(
                  width: 90.w,
                  child: ReactiveTextField(
                    formControlName: "name",
                    maxLines: 1,
                    maxLength: 20,
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'The email must not be empty',
                      ValidationMessage.minLength: (_) =>
                          translation.appTextFieldNameTooShortLabel.tr,
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      helperText: '',
                      helperStyle: TextStyle(height: 0.7),
                      errorStyle: TextStyle(height: 0.7),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(
                    AppLayout.getHeight(2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      controller.income.value
                          ? Text(
                              "+",
                              style:
                                  TextStyle(fontSize: 32.sp,),
                            )
                          : Text(
                              "-",
                              style:
                                  TextStyle(fontSize: 32.sp,),
                            ),
                      Container(
                        child: Text(
                          NumberFormat.simpleCurrency(
                                  locale: locale?.languageCode)
                              .currencySymbol,
                          style: TextStyle(
                            fontSize: 24.sp,
                          ),
                        ),
                      ),
                      Gap(5),
                      SizedBox(
                          width: 60.w,
                          child: ReactiveTextField(
                            formControlName: "total_value",
                            inputFormatters: [
                              CurrencyInputFormatter(
                                thousandSeparator: ThousandSeparator.Space,
                                mantissaLength: 2,
                              )
                            ],
                            decoration: InputDecoration(labelText: "Amount"),
                          )

                          // TextFormField(
                          //   controller: controller.amount,
                          //   decoration: InputDecoration(
                          //     labelText: translation.appTextFieldAmountLabel.tr,
                          //   ),
                          //   keyboardType: const TextInputType.numberWithOptions(
                          //       decimal: true),
                          //   inputFormatters: [
                          //     CurrencyInputFormatter(
                          //       thousandSeparator: ThousandSeparator.Space,
                          //       mantissaLength: 2,
                          //     )
                          //   ],
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return translation.appTextFieldAmountEmptyLabel.tr;
                          //     } else if (double.tryParse(
                          //             value.removeAllWhitespace)! <=
                          //         0) {
                          //       return translation.appTextFieldAmountNullLabel.tr;
                          //     }
                          //     return null;
                          //   },
                          // ),
                          ),
                    ],
                  ),
                ),

                Container(
                  // padding: EdgeInsets.only(
                  //   top: AppLayout.getHeight(5),
                  //   left: AppLayout.getHeight(10),
                  //   right: AppLayout.getHeight(10),
                  // ),
                  width: 90.w,
                  child: ReactiveDateTimePicker(
                    formControlName: 'creation_date',
                    firstDate: DateTime(DateTime.now().year),
                    valueAccessor: DateTimeValueAccessor(
                        dateTimeFormat: DateFormat("dd MMM yyyy")),
                    decoration: InputDecoration(
                      labelText: translation.appGoalDeadlineDateLabel.tr,
                      // border: OutlineInputBorder(),
                      helperText: '',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                  ),

                  // TextFormField(
                  //   controller: controller.dateInput,
                  //   decoration: InputDecoration(
                  //       icon: const Icon(Icons.calendar_today),
                  //       //icon of text field
                  //       labelText:
                  //           translation.appTransactionNewTransactionDateLabel.tr),
                  //   readOnly: true,
                  //   onTap: () async {
                  //     controller.chooseDate();
                  //   },
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return translation
                  //           .appTransactionNewTransactionDateEmptyLabel.tr;
                  //     }
                  //     return null;
                  //   },
                  // ),
                ),

                Gap(15),

                Container(
                  width: 90.w,
                  // margin:
                  //     EdgeInsets.symmetric(horizontal: AppLayout.getHeight(20)),
                  child: ReactiveTextField(
                    formControlName: "description",
                    maxLength: 50,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: translation.appTextFieldDescriptionLabel.tr,
                    ),
                  ),
                ),

                Gap(15),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                    //   child: Text(translation.appTextFieldPaymentModeLabel.tr),
                    // ),
                    // Obx(() =>
                    Container(
                      width: 90.w,
                      // padding: EdgeInsets.all(AppLayout.getHeight(10)),
                      child: ReactiveDropdownField<int>(
                        formControlName: 'payment_method',
                        hint: Text(translation.appTextFieldPaymentModeLabel.tr),
                        // onChanged: (newValue) {
                        //   controller.updatePaymentType(
                        //       newValue.value!); //paymentCode.value = newValue!;
                        // },
                        //     value: controller.paymentType.value.key,
                        items: paymentTypes
                            .map<DropdownMenuItem<int>>((PaymentType payment) {
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
                      //   () => DropdownButtonFormField<int>(
                      //     decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: Theme.of(context).brightness ==
                      //                   Brightness.light
                      //               ? Colors.black
                      //               : Colors.white,
                      //           width: 2,
                      //         ),
                      //         borderRadius:
                      //             BorderRadius.circular(AppLayout.getHeight(10)),
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: Theme.of(context).brightness ==
                      //                   Brightness.light
                      //               ? Colors.black
                      //               : Colors.white,
                      //           width: 2,
                      //         ),
                      //         borderRadius:
                      //             BorderRadius.circular(AppLayout.getHeight(10)),
                      //       ),
                      //     ),
                      //     onChanged: (newValue) {
                      //       controller.updatePaymentType(newValue!); //paymentCode.value = newValue!;
                      //     },
                      //     value: controller.paymentType.value.key,
                      //     items: paymentTypes
                      //         .map<DropdownMenuItem<int>>((PaymentType payment) {
                      //       return DropdownMenuItem<int>(
                      //         value: payment.key,
                      //         child: Text(payment.value!),
                      //       );
                      //     }).toList(),
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
                    // ),
                  ],
                ),

                Gap(15),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   padding: EdgeInsets.only(
                    //     left: AppLayout.getHeight(15),
                    //   ),
                    //   child: Text(translation.appTextFieldAccountLabel.tr),
                    // ),
                    // Obx(() =>
                    Obx(() => Container(
                      // padding: EdgeInsets.all(AppLayout.getHeight(10)),
                      width: 90.w,
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
                    //   () => DropdownButtonFormField<String>(
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
                    //         borderRadius:
                    //             BorderRadius.circular(AppLayout.getHeight(10)),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           //color: Colors.blue;
                    //           width: AppLayout.getHeight(2),
                    //         ),
                    //         borderRadius:
                    //             BorderRadius.circular(AppLayout.getHeight(10)),
                    //       ),
                    //       // filled: true;
                    //       // fillColor: Colors.blueAccent;
                    //     ),
                    //     validator: (value) => value == null
                    //         ? translation.appTextFieldEmptyAccountLabel.tr
                    //         : null,
                    //     //dropdownColor: Colors.blueAccent;
                    //     value: controller.selectedAccount.value.id,
                    //     onChanged: (newValue) {
                    //       //controller.selectedAccount.value = newValue?.id;
                    //       controller.updateAccount(newValue!);
                    //     },
                    //     items: controller.accounts
                    //         .map<DropdownMenuItem<String>>((AppAccount el) {
                    //       return DropdownMenuItem<String>(
                    //         value: el.id,
                    //         child: Text(el.name!),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                    // ),),
                  ],
                ),

                Gap(15),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   padding: EdgeInsets.only(left: AppLayout.getHeight(10)),
                    //   child: Text(translation.appTextFieldCategoryLabel.tr),
                    // ),
                    Obx(() =>
                    Container(
                      // padding: EdgeInsets.all(AppLayout.getHeight(10)),
                      width: 90.w,
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

                    // Obx(
                    //   () => DropdownButtonFormField<String>(
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
                    //           color: Theme.of(context).brightness ==
                    //                   Brightness.light
                    //               ? Colors.black
                    //               : Colors.white,
                    //           width: 2,
                    //         ),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       // filled: true;
                    //       // fillColor: Colors.blueAccent;
                    //     ),
                    //     validator: (value) => value == null
                    //         ? translation.appTextFieldEmptyCategoryLabel.tr
                    //         : null,
                    //     //dropdownColor: Colors.blueAccent;
                    //     value: controller.selectedCategory.value.id,
                    //     onChanged: (value) {
                    //       controller.updateCategory(value!);
                    //     },
                    //     items: controller.filteredCategories
                    //         .map<DropdownMenuItem<String>>((AppCategory el) {
                    //       return DropdownMenuItem<String>(
                    //         value: el.id,
                    //         child: Text(el.name!),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                    // ),
                    // ),
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           child: Text(translation.appTextFieldAccountLabel.tr),
                //           padding: EdgeInsets.only(left: 15),
                //         ),
                //         Container(
                //           padding: EdgeInsets.only(left: 10),
                //           width: AppLayout.getScreenWidth() * 0.45,
                //           child: Obx(
                //             () => DropdownButtonFormField<int>(
                //               //hint: Text("Select an account");
                //               decoration: InputDecoration(
                //                 enabledBorder: OutlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Theme.of(context).brightness ==
                //                             Brightness.light
                //                         ? Colors.black
                //                         : Colors.white,
                //                     width: 2,
                //                   ),
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 border: OutlineInputBorder(
                //                   borderSide: BorderSide(
                //                     //color: Colors.blue;
                //                     width: 2,
                //                   ),
                //                   borderRadius: BorderRadius.circular(20),
                //                 ),
                //                 // filled: true;
                //                 // fillColor: Colors.blueAccent;
                //               ),
                //               validator: (value) => value == null
                //                   ? translation.appTextFieldEmptyAccountLabel.tr
                //                   : null,
                //               //dropdownColor: Colors.blueAccent;
                //               value: controller.selectedAccount.value,
                //               onChanged: (newValue) {
                //                 //controller.selectedAccount.value = newValue?.id;
                //                 controller.updateAccount(newValue!);
                //               },
                //               items: controller.accounts
                //                   .map<DropdownMenuItem<int>>((AppAccount el) {
                //                 return DropdownMenuItem<int>(
                //                   child: Text(el.name!),
                //                   value: el.id,
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           child: Text(translation.appTextFieldCategoryLabel.tr),
                //           padding: EdgeInsets.only(left: 10),
                //         ),
                //         Container(
                //           padding: EdgeInsets.only(right: 10),
                //           width: AppLayout.getScreenWidth() * 0.45,
                //           color: Colors.red,
                //           child: Obx(
                //             () => DropdownButtonFormField<int>(
                //               decoration: InputDecoration(
                //                 enabledBorder: OutlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Theme.of(context).brightness ==
                //                             Brightness.light
                //                         ? Colors.black
                //                         : Colors.white,
                //                     width: 2,
                //                   ),
                //                   borderRadius: BorderRadius.circular(20),
                //                 ),
                //                 border: OutlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Theme.of(context).brightness ==
                //                             Brightness.light
                //                         ? Colors.black
                //                         : Colors.white,
                //                     width: 2,
                //                   ),
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 // filled: true;
                //                 // fillColor: Colors.blueAccent;
                //               ),
                //               validator: (value) => value == null
                //                   ? translation
                //                       .appTextFieldEmptyCategoryLabel.tr
                //                   : null,
                //               //dropdownColor: Colors.blueAccent;
                //               value: controller.selectedCategory.value,
                //               onChanged: (value) {
                //                 controller.updateCategory(value!);
                //               },
                //               items: controller.categories
                //                   .map<DropdownMenuItem<int>>((AppCategory el) {
                //                 return DropdownMenuItem<int>(
                //                   child: Text(el.name!),
                //                   value: el.id,
                //                 );
                //               }).toList(),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),

                Column(
                  children: [
                    SizedBox(
                      height: AppLayout.getHeight(100),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// getRoutineTypeList(BuildContext context) {
//   var types = [
//     PaymentType(713,
//         AppLocalizations.of(context)!.user_routine_payment_type_cash_text),
//     PaymentType(715,
//         AppLocalizations.of(context)!.user_routine_payment_type_credit_text),
//     PaymentType(717,
//         AppLocalizations.of(context)!.user_routine_payment_type_debt_text),
//     PaymentType(719,
//         AppLocalizations.of(context)!.user_routine_payment_type_salary_text),
//     PaymentType(721,
//         AppLocalizations.of(context)!.user_routine_payment_type_extra_text),
//     PaymentType(723,
//         AppLocalizations.of(context)!.user_routine_payment_type_labor_text),
//     PaymentType(
//         725,
//         AppLocalizations.of(context)!
//             .user_routine_payment_type_commission_text),
//     PaymentType(727,
//         AppLocalizations.of(context)!.user_routine_payment_type_study_text),
//     PaymentType(729,
//         AppLocalizations.of(context)!.user_routine_payment_type_sales_text),
//     PaymentType(
//         731,
//         AppLocalizations.of(context)!
//             .user_routine_payment_type_freelancing_text),
//     PaymentType(733,
//         AppLocalizations.of(context)!.user_routine_payment_type_rent_text),
//     PaymentType(735,
//         AppLocalizations.of(context)!.user_routine_payment_type_fee_text),
//     PaymentType(
//         737,
//         AppLocalizations.of(context)!
//             .user_routine_payment_type_royalties_text),
//     PaymentType(739,
//         AppLocalizations.of(context)!.user_routine_payment_type_profits_text),
//     PaymentType(
//         741,
//         AppLocalizations.of(context)!
//             .user_routine_payment_type_retirement_text),
//     PaymentType(
//         743,
//         AppLocalizations.of(context)!
//             .user_routine_payment_type_marketing_text),
//   ];
//
//   return types;
// }
}
