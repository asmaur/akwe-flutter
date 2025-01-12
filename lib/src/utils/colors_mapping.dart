import 'package:flutter/material.dart';



class AppColorList{
  static const Color APPCOLOR001 = Color(0xFF0099CC);
  static const Color APPCOLOR002 = Color(0xFF9933FF);
  static const Color APPCOLOR003 = Color(0xFF669900);
  static const Color APPCOLOR004 = Color(0xFFFF8A00);
  static const Color APPCOLOR005 = Color(0xFFCC0000);
  static const Color APPCOLOR006 = Color(0xFF2CB1E1);
  static const Color APPCOLOR007 = Color(0xFFC58BE2);
  static const Color APPCOLOR008 = Color(0xFF99CC00);
  static const Color APPCOLOR009 = Color(0xFFFFBD21);
  static const Color APPCOLOR010 = Color(0xFFFF4444);
  static const Color APPCOLOR011 = Color(0xFF8AD5F0);
  static const Color APPCOLOR012 = Color(0xFFD6ADEB);
  static const Color APPCOLOR013 = Color(0xFFC5E26D);
  static const Color APPCOLOR014 = Color(0xFFFFD980);
  static const Color APPCOLOR015 = Color(0xFFFF9494);
  static const Color APPCOLOR016 = Color(0xFF3B3B3B);
  static const Color APPCOLOR017 = Color(0xFF686868);
  static const Color APPCOLOR018 = Color(0xFF8F8F8F);
  static const Color APPCOLOR019 = Color(0xFFBCBCBC);
  static const Color APPCOLOR020 = Color(0xFF2A14FF);
  static const Color APPCOLOR021 = Color(0xFF439996);
  static const Color APPCOLOR022 = Color(0xFF004E09);
  static const Color APPCOLOR023 = Color(0xFFF6FF00);
  static const Color APPCOLOR024 = Color(0xFFC2C900);
  static const Color APPCOLOR025 = Color(0xFFA5009F);
  static const Color APPCOLOR026 = Color(0xFFBB6E00);
  static const Color APPCOLOR027 = Color(0xFF930101);
  static const Color APPCOLOR028 = Color(0xFFA2B6C2);
  static const Color APPCOLOR029 = Color(0xFF000000);
  static const Color APPCOLOR030 = Color(0xFF24847A);
  static const Color APPCOLOR031 = Color(0xFF02234E);
  static const Color APPCOLOR032 = Color(0xFF6E8F8E);
}

List<Color> appDataColors = [
  AppColorList.APPCOLOR001,
  AppColorList.APPCOLOR002,
  AppColorList.APPCOLOR003,
  AppColorList.APPCOLOR004,
  AppColorList.APPCOLOR005,
  AppColorList.APPCOLOR006,
  AppColorList.APPCOLOR007,
  AppColorList.APPCOLOR008,
  AppColorList.APPCOLOR009,
  AppColorList.APPCOLOR010,
  AppColorList.APPCOLOR011,
  AppColorList.APPCOLOR012,
  AppColorList.APPCOLOR013,
  AppColorList.APPCOLOR014,
  AppColorList.APPCOLOR015,
  AppColorList.APPCOLOR016,
  AppColorList.APPCOLOR017,
  AppColorList.APPCOLOR018,
  AppColorList.APPCOLOR019,
  AppColorList.APPCOLOR020,
  AppColorList.APPCOLOR021,
  AppColorList.APPCOLOR022,
  AppColorList.APPCOLOR023,
  AppColorList.APPCOLOR024,
  AppColorList.APPCOLOR025,
  AppColorList.APPCOLOR026,
  AppColorList.APPCOLOR027,
  AppColorList.APPCOLOR028,
  AppColorList.APPCOLOR029,
  AppColorList.APPCOLOR030,
  AppColorList.APPCOLOR031,
  AppColorList.APPCOLOR032,
];

class ColorMapping {
  Map<String, Color> colorMapping = {};

  Color? getColor(String value){
    return colorMapping[value];
  }

  String? getColorKey(Color color){
    return colorMapping.keys.firstWhere((element) => colorMapping[element]?.value == color.value);
  }

}