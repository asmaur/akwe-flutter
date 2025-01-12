import 'package:flutter/material.dart';
import 'package:akwe/src/utils/app_color.dart';

class ColorTile extends StatelessWidget {
  final AppColor selectedColor;
  const ColorTile(this.selectedColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 25,
      child: Container(
        decoration: BoxDecoration(
          color: selectedColor.color,//Colors.red,
          shape: BoxShape.circle,
          border: const Border()
        ),
        child: const Icon(Icons.check, size: 20, color: Colors.white,),
      ),
    );
  }
}
