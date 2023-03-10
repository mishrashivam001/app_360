import 'package:app_360/controller/view_models/rate_view_model.dart';
import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/core/utils/sizer.dart';
import 'package:app_360/ui/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
  }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  final String title, description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return BaseStatelessView<RatesViewModel>(builder: (context, model, child) {
      if (model.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/app_logo.svg",
              height: 10.h,
              width: 30.w,
            ),
            SizedBox(
              height: 4.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 7.w,
                ),
                Image(image: NetworkImage(image.toString()), height: 10.w),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "\$${description.toUpperCase()}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp),
                ),
                SizedBox(
                  width: 7.w,
                ),
              ],
            ),
            Text(description),
            Padding(
              padding: EdgeInsets.only(right: 7.w, left: 7.w),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: _controller,
                cursorColor: AppColors.lightOnPrimaryColor,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    // contentPadding: EdgeInsets.all(3.w),
                    hintText: "Enter Number Of Coins",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.dialogEditBg,
                        width: 2,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColors.dialogEditBg,
                      width: 1,
                    )),
                    hintStyle: TextStyle(color: AppColors.dialogEditBg)),
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 5.w),
                InkWell(
                  onTap: () async {
                    final sendCoins =
                        await model.coinsData(title, _controller.text);
                    if (sendCoins != null) {
                      print("result => $sendCoins ");
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.appIconColor,
                        borderRadius: BorderRadius.all(Radius.circular(2.w))),
                    padding: EdgeInsets.only(
                        top: 3.5.w, bottom: 3.5.w, left: 10.w, right: 10.w),
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(2.w))),
                    padding: EdgeInsets.only(
                        top: 3.5.w, bottom: 3.5.w, left: 8.w, right: 8.w),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
            SizedBox(
              height: 5.w,
            ),
          ],
        ),
      );
    });
  }
}
