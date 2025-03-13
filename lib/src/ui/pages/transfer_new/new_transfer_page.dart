import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;

import 'new_transfer_page_controller.dart';

class NewTransferPage extends StatelessWidget {
  const NewTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewTransferPageController>();
    final newTransferFormKey = GlobalKey<FormState>();
    final locale = Get.deviceLocale;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation.appTransferNewTransferTitleText.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (newTransferFormKey.currentState!.validate()) {
                controller.createNewTransfer();
              }
            },
            child: Text(
              translation.appSaveButtonLabel.tr,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
        //backgroundColor: Theme.of(context).brightness == Brightness.light ??,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: newTransferFormKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppLayout.getHeight(10),
                ),
                child: SizedBox(
                  child: TextFormField(
                    controller: controller.name,
                    maxLength: 20,
                    decoration: InputDecoration(
                      label: Text(
                        translation.appTextFieldNameLabel.tr,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translation.appTextFieldNameEmptyLabel.tr;
                      } else if (value.trim().length < 5) {
                        return translation.appTextFieldNameTooShortLabel.tr;
                      } else if (value.length > 19) {
                        return translation.appTextFieldNameTooLongLabel.tr;
                      }
                      return null;
                    },
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
                      child: TextFormField(
                        controller: controller.amount,
                        decoration: InputDecoration(
                          labelText: translation.appTextFieldAmountLabel.tr,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          CurrencyInputFormatter(
                            thousandSeparator: ThousandSeparator.Space,
                            mantissaLength: 2,
                          )
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translation.appTextFieldAmountEmptyLabel.tr;
                          } else if (double.tryParse(
                                  value.removeAllWhitespace)! <=
                              0) {
                            return translation.appTextFieldAmountNullLabel.tr;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: AppLayout.getHeight(5),
                  left: AppLayout.getHeight(10),
                  right: AppLayout.getHeight(10),
                ),
                child: TextFormField(
                  controller: controller.dateInput,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      //icon of text field
                      labelText:
                          translation.appTransactionNewTransactionDateLabel.tr),
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
              Gap(AppLayout.getHeight(10)),
              Gap(AppLayout.getHeight(10)),
              Obx(
                () => ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: Text(
                    translation.appTransferProcessNowLabelText.tr,
                  ),
                  enabled: true,
                  onTap: () => controller.toggle(),
                  //enableFeedback: true;
                  trailing: Switch(
                    onChanged: (value) => controller.toggle(),
                    value: controller.processed.value,
                  ),
                ),
              ),
              const Gap(10),
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
                    padding: EdgeInsets.all(AppLayout.getHeight(10)),
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
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(10)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              //color: Colors.blue;
                              width: AppLayout.getHeight(2),
                            ),
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(10)),
                          ),
                          // filled: true;
                          // fillColor: Colors.blueAccent;
                        ),
                        validator: (value) => value == null
                            ? translation.appTextFieldEmptyAccountLabel.tr
                            : null,
                        //dropdownColor: Colors.blueAccent;
                        value: controller.fromSelectedAccount.value.id,
                        onChanged: (newValue) {
                          //controller.selectedAccount.value = newValue?.id;
                          controller.updateFromAccount(newValue!);
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
                  ),
                ],
              ),
              Gap(AppLayout.getHeight(10)),
              const Icon(
                Icons.arrow_downward,
                size: 32,
              ),
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
                    padding: EdgeInsets.all(AppLayout.getHeight(10)),
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
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(10)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              //color: Colors.blue;
                              width: AppLayout.getHeight(2),
                            ),
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(10)),
                          ),
                          // filled: true;
                          // fillColor: Colors.blueAccent;
                        ),
                        validator: (value) => value == null
                            ? translation.appTextFieldEmptyAccountLabel.tr
                            : null,
                        //dropdownColor: Colors.blueAccent;
                        value: controller.inSelectedAccount.value.id,
                        onChanged: (newValue) {
                          //controller.selectedAccount.value = newValue?.id;
                          controller.updateInAccount(newValue!);
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
                  ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: AppLayout.getHeight(20)),
                child: SizedBox(
                  child: TextFormField(
                    controller: controller.description,
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
            ],
          ),
        ),
      ),
    );
  }
}
