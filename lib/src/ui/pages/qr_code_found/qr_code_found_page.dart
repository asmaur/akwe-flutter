import 'package:akwe/src/constants/app_colors.dart';
import 'package:akwe/src/constants/app_layout.dart';
import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:akwe/src/ui/pages/qr_code_found/qr_code_found_page_controller.dart';
import 'package:akwe/src/ui/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:akwe/src/utils/payment_type.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:reactive_forms/reactive_forms.dart';

class QrCodeFoundPage extends StatelessWidget {
  QrCodeFoundPage({super.key});
  final controller = Get.find<QrCodeFoundPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            translation.appQrCodeCreateNewTransactionLabel.tr,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 24, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.createNewTransaction();
            },
            child: Text(
              translation.appSaveButtonLabel.tr,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
        backgroundColor: Colors.redAccent,
      ),
      drawer: AppDrawerMobile(),
      body: SingleChildScrollView(
        child: ReactiveForm(
          formGroup: controller.form,
          child:
            Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: AppLayout.getHeight(350),
                    //margin: EdgeInsets.all(5);
                    child: ReactiveTextField(
                      formControlName: "invoice_url",
                      readOnly: true,
                      maxLines: null,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.link),
                        labelText: translation.appInvoiceLinkLabel.tr,
                      ),
                      style: TextStyle(
                          color:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.blue
                              : Colors.white),

                    ),
                  ),
                ),
                Gap(40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: AppLayout.getWidth(5), right: AppLayout.getWidth(5),),
                      child:
                      Text(translation.appTextFieldPaymentModeLabel.tr),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(5)),
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
                    ),
                  ],
                ),
                Gap(40),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                          EdgeInsets.only(left: AppLayout.getWidth(5), right: AppLayout.getWidth(5),),
                          child:
                          Text(translation.appTextFieldAccountLabel.tr),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(5)),
                          //width: AppLayout.getScreenWidth() * 0.45,
                          child: Obx(() => Container(
                            padding: EdgeInsets.all(AppLayout.getWidth(1)),
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
                        ),
                      ],
                    ),
                    Gap(40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                          EdgeInsets.only(left: AppLayout.getWidth(5), right: AppLayout.getWidth(5),),
                          child:
                          Text(translation.appTextFieldCategoryLabel.tr),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(5)),
                          //width: AppLayout.getScreenWidth() * 0.45,
                          child: Obx(() =>
                              Container(
                                padding: EdgeInsets.all(AppLayout.getWidth(1)),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // const Gap(20),
            // const Gap(20),

        ),
      ),
    );
  }
}
