import 'dart:convert';

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

  Future retrieve(String key, String id) async {}

  /**
   * Save individual items
   */
  Future create(String key, dynamic data) async{}

  Future update() async {}

  Future delete() async {}

}