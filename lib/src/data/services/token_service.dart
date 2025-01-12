

import 'package:akwe/src/constants/endpoint.dart';
import 'package:akwe/src/networking/base_service.dart';

class TokenService{
  final BaseService _baseService = BaseService();

  Future setDeviceToken(dynamic data) async{
    return await _baseService.post("${Endpoint.USERURL}/device/", data: data);
  }

}