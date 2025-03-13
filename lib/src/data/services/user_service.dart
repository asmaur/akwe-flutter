import 'dart:io';

import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';
import 'package:akwe/src/ui/shared/dialog_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserService {
  final BaseService _baseService = BaseService();

  Future<Response> getUser() async {
    DialogHelper.showLoading();
    try {
      final Response response = await _baseService.get(Endpoint.ACCOUNTURL,);
      DialogHelper.hideLoading();
      if (response.statusCode == 200) {
        print(response.data);
      }
      return response;
    } on SocketException{
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog(description: "Network Error: Check internet connection");
      rethrow;
    } on DioException {
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog();
      rethrow;
    } catch (e) {
      DialogHelper.hideLoading();
      DialogHelper.showErrorDialog();
      rethrow;
    }
  }

  Future<Response> initializeNewUser() async{
    debugPrint(":::::::CALLING NEW USER INITIALIZATION:::::::::::::");
    return await _baseService.post("${Endpoint.USERURL}initialize/");
  }

  Future<Response> resetUserData() async{
    return await _baseService.post("${Endpoint.USERURL}reset/");
  }
  
  getUserProfile() async{
    return await _baseService.get("${Endpoint.USERURL}/profile/");
  }

  updateUserProfile(dynamic data) async{
    return await _baseService.put("${Endpoint.USERURL}/update-profile/", data: data);
  }

  Future<Response> initializeUserWithEmailAndPassword(Map<String, dynamic> data) async{
    debugPrint(":::::::CALLING NEW USER INITIALIZATION:::::::::::::");
    return await _baseService.post("${Endpoint.USERURL}/register/", data: data);
  }

}
