import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/core/utils/sizer.dart';
import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

class CustomRadio {
  final int key;
  final String text;
  final Function(bool) onChanged;
  final bool isSelect;

  const CustomRadio(
      {required this.key,
      required this.text,
      required this.onChanged,
      required this.isSelect});
}

class RadioModel extends StatelessWidget {
  final CustomRadio _item;
  const RadioModel(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: () {
        _item.onChanged(!_item.isSelect);
      },
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: AppColors.iconTopColor, width: 0.5.w),
            color: _item.isSelect ? AppColors.iconTopColor : Colors.white),
        child: Text(_item.text,
            style: TextStyle(
                color: _item.isSelect ? Colors.white : AppColors.iconTopColor,
                fontSize: 12.sp)),
      ),
    );
  }
}
