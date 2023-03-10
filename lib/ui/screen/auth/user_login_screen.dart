import 'package:app_360/controller/view_models/login_view_model.dart';
import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/core/router/assets_route.dart';
import 'package:app_360/core/router/screen_routes.dart';
import 'package:app_360/core/utils/sizer.dart';
import 'package:app_360/ui/base_view.dart';
import 'package:app_360/ui/screen/custom/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';

class UserLoginScreen extends StatelessWidget {
  UserLoginScreen({super.key});

  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _buildRegisterContent(context)),
    );
  }

  Widget _buildRegisterContent(context) {
    return BaseStatelessView<LoginViewModel>(builder: (context, model, child) {
      if (model.loading) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: AppColors.darkSecondaryColor,
                  )),
              SizedBox(
                height: 5.w,
              ),
              Text(
                "Loading...",
                style: TextStyle(
                    color: AppColors.darkSecondaryColor, fontSize: 10.sp),
              )
            ],
          ),
        );
      }
      return Form(
        key: _formKey,
        child: Column(
          // key: _formKey,
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
                    color: AppColors.darkSecondaryColor,
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
                      "Login",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  _buildTextField(
                      "Email",
                      userNameController,
                      const Icon(
                        Icons.person,
                      ), (value) {
                    return UserInfo.emailValidator(value);
                  }),
                  SizedBox(
                    height: 10.w,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  _buildTextField(
                      "Enter Your Password",
                      passcontroller,
                      const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ), (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter The Password";
                    }
                    if (value.length < 5) {
                      return "Please Enter Strong Password";
                    }
                    return null;
                  }),
                  _buildTerms(model),
                  SizedBox(
                    height: 10.w,
                  ),
                  _buildButton("Login Now", () async {
                    EasyLoading.dismiss();
                    if (passcontroller.text.isNotEmpty &&
                        userNameController.text.isNotEmpty) {
                      final result = await model.login(
                          userNameController.text, passcontroller.text);
                      EasyLoading.show();
                      if (result != null &&
                          userNameController.text.isNotEmpty &&
                          passcontroller.text.isNotEmpty) {
                        EasyLoading.dismiss();
                        print("result => $result ");
                        Navigator.pushNamed(
                            context, ScreenRoutes.dashboardScreen,
                            arguments: result);
                      }
                    }

                    if (_formKey.currentState?.validate() ?? true) {
                      // print("username : ${userNameController.text}");
                    }
                  }),
                  SizedBox(
                    height: 5.w,
                  ),
                  Center(
                    child: _buildText(
                        "DON'T HAVE AN ACCOUNT?", " REGISTER HERE", () {
                      Navigator.pushNamed(
                          context, ScreenRoutes.userRegistration);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTextField(String text, TextEditingController controller,
      Icon icon, String? Function(String?) validator) {
    return Container(
      // padding: EdgeInsets.only(left: 2.w, right: 1.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
          color: Colors.grey[600]?.withOpacity(0.3)),
      child: TextFormField(
        // key: _formKey,
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        validator: validator,
        decoration: InputDecoration(
          hintText: text,
          prefixIcon: icon,
          border: InputBorder.none,
        )
        // validator: (value) {

        // }
        ,
      ),
    );
  }

  Widget _buildTerms(LoginViewModel model) {
    return Row(
      children: [
        Checkbox(
          activeColor: AppColors.appIconColor,
          value: model.isChecked,
          onChanged: (value) {
            model.setCheckbox(value ?? false);
          },
        ),
        Text(
          "Remember Me",
          style: TextStyle(
            fontSize: 9.sp,
          ),
        )
      ],
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

  Widget _buildText(String text1, String text2, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
              text: text1,
              style: TextStyle(fontSize: 9.sp),
              children: <InlineSpan>[
                TextSpan(
                  text: text2,
                  style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
                ),
              ])),
    );
  }
}
