import 'dart:convert';

import 'package:akwe/src/models/accounts/app_account.dart';
import 'package:akwe/src/models/categories/app_category.dart';
import 'package:akwe/src/models/routines/routine.dart';
import 'package:akwe/src/models/transactions/app_transaction.dart';
import 'package:get_storage/get_storage.dart';

class StorageService{
  final _storage = GetStorage();

  /**
   * Return a list of saved items
   */
  Future<List<dynamic>> list(String key) async {
    var data = await _storage.read(key) ?? [];
    return data;
  }

  setList(String key, List<dynamic> data) async {
    await _storage.write(key, data);
  }

  Future retrieve(String key, String id) async {
    var rawData = await _storage.read(key);
    switch (key){
      case "accounts":
        List<AppAccount> data = [];
        rawData.forEach((el){
          data.add(AppAccount.fromJson(el));
        });
        return data.singleWhere((element) => element.id==id);

      case "categories":
        List<AppCategory> data = [];
        rawData.forEach((el){
          data.add(AppCategory.fromJson(el));
        });
        return data.singleWhere((element) => element.id==id);

      case "transactions":
        List<Transaction> data = [];
        rawData.forEach((el){
          data.add(Transaction.fromJson(el));
        });
        return data.singleWhere((element) => element.id==id);

      case "routines":
        List<Routine> data = [];
        rawData.forEach((el){
          data.add(Routine.fromJson(el));
        });
        return data.singleWhere((element) => element.id==id);
    }

    // return rawData.singleWhere((element) => element.id==id);
  }

  /**
  * Save individual items
  */
  Future create(String key, value) async{
    // print("::::::::SETTING TOKEN $value  :::::");
    await _storage.write(key, value);
  }

  Future<dynamic> get(String key) async {
    // print("::::::::CALLING GETTER TOKEN:::::");
    return await _storage.read(key);
  }

  Future update() async {}

  Future delete() async {}

  Future<void> reset(String key) async{
    await _storage.remove(key);
  }

  Future<void> erase() async{
    await _storage.erase();
  }

}