import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/core/router/screen_routes.dart';
import 'package:app_360/core/utils/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgetPassScreen extends StatelessWidget {
  ForgetPassScreen({super.key});

  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _rePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _buildRegisterContent(context)),
    );
  }

  Widget _buildRegisterContent(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          color: AppColors.appIconColor,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SvgPicture.asset(
                "assets/app_logo.svg",
                color: Colors.white,
                height: 10.h,
                // width: double.infinity,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                textAlign: TextAlign.center,
                "BistSoft 360 Login Page",
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              Image.asset(
                "assets/bit_image.jpg",
                fit: BoxFit.fill,
                height: 20.h,
                width: double.infinity,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.w, right: 5.w, left: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              Center(
                child: Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 2.w,
              ),
              _buildTextField(
                "Enter Your New Password",
                _passcontroller,
              ),
              SizedBox(
                height: 10.w,
              ),
              _buildTextField(
                "Re-Enter Your Password",
                _rePassController,
              ),
              SizedBox(
                height: 10.w,
              ),
              _buildButton("Confirm", () {
                Navigator.pushNamed(context, ScreenRoutes.userLogin);
              }),
              SizedBox(
                height: 5.w,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String text, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(left: 4.w, right: 1.w),
      height: 12.w,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
          color: Colors.grey[600]?.withOpacity(0.3)),
      child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: text,
            border: InputBorder.none,
          )),
    );
  }

  Widget _buildButton(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.5.h,
        width: double.infinity,
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.w)),
            color: AppColors.appIconColor),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
            ),
          ),
        ),
      ),
    );
  }
}
