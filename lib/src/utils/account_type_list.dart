import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:akwe/src/translations/translation_keys.dart' as translation;
import 'package:flutter/material.dart';
import 'package:akwe/src/models/account_type.dart';

getAccountType() {
  var types = [
    AccountType(
      11,
      translation.userAccountType011.tr,
      const Icon(Icons.wallet_outlined),
    ),
    AccountType(
      25,
      translation.userAccountType025.tr,
      //translation.userAccountType011.tr,
      const Icon(Icons.monetization_on_outlined),
    ),
    AccountType(
      13,
      translation.userAccountType013.tr,
      const Icon(Icons.credit_card),
    ),
    AccountType(
      15,
      translation.userAccountType015.tr,
      const Icon(Icons.savings),
    ),
    AccountType(
      17,
      translation.userAccountType017.tr,
      const Icon(Icons.candlestick_chart_outlined),
    ),
    AccountType(
      19,
      translation.userAccountType019.tr,
      const Icon(Icons.border_all_outlined),
    ),
    AccountType(
      21,
      translation.userAccountType021.tr,
       const Icon(Icons.shopping_basket_outlined),
    ),
    AccountType(
      23,
      translation.userAccountType023.tr,
      const Icon(FontAwesomeIcons.utensils),
    ),
  ];

  return types;
}
