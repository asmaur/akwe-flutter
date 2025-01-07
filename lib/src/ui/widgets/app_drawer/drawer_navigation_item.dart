import 'package:akwe/src/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerNavigationItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? trealing;

  DrawerNavigationItem({
    super.key,
    required this.iconData,
    required this.label,
    required this.selected,
    this.onTap,
    this.trealing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        leading: Icon(iconData),
        title: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        trailing: trealing,
        selectedTileColor: AppColors.appLightBlue,
        hoverColor: AppColors.appLightBlue,
        selected: selected,
        onTap: onTap,
      ),
    );
  }
}
