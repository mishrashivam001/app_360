import 'package:app_360/controller/view_models/user_register_view_model.dart';
import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/core/router/screen_routes.dart';
import 'package:app_360/core/utils/sizer.dart';
// import 'package:app_360/data/network/api_service.dart';
// import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../base_view.dart';
import '../custom/user_widget.dart';

class UserRegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNamecontroller = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final password = RandomPasswordGenerator();
  final _formKey = GlobalKey<FormState>();

  UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildRegisterContent(context),
    );
  }

  Widget _buildRegisterContent(context) {
    // ApiServices.instance.printIps();

    return BaseStatefulView<UserRegisterViewModel>(
        loadOnInit: (model) => model.init(),
        builder: (context, model, child) {
          // if (model.loading) {
          //   return Center(
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         const Align(
          //             alignment: Alignment.center,
          //             child: CircularProgressIndicator(
          //               color: AppColors.darkSecondaryColor,
          //             )),
          //         SizedBox(
          //           height: 5.w,
          //         ),
          //         Text(
          //           "Loading...",
          //           style: TextStyle(
          //               color: AppColors.darkSecondaryColor, fontSize: 10.sp),
          //         )
          //       ],
          //     ),
          //   );
          // }
          _passwordController.text = model.password;
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
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
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "The Official App For The \n BitQs Trading System",
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        _buildfNameTextField(
                            "First Name",
                            _firstNamecontroller,
                            TextInputType.name,
                            _firstNamecontroller.text, (value) {
                          return UserInfo.fNameValidator(value!);
                        }),
                        SizedBox(
                          height: 3.w,
                        ),
                        _buildfNameTextField(
                            "Last Name",
                            _lastNameController,
                            TextInputType.name,
                            _lastNameController.text, (value) {
                          return UserInfo.lNameValidator(value!);
                        }),
                        SizedBox(
                          height: 3.w,
                        ),
                        _buildfNameTextField(
                            "Your Email",
                            _emailController,
                            TextInputType.emailAddress,
                            _emailController.text, (value) {
                          return UserInfo.emailValidator(value);
                        }),
                        SizedBox(
                          height: 3.w,
                        ),
                        _buildPasssword(context, model),
                        SizedBox(
                          height: 3.w,
                        ),
                        _buildPhone(model.prefix),
                        // _buildTerms(model),
                        SizedBox(
                          height: 6.w,
                        ),
                        _buildButton("Register Now", model, context),
                        SizedBox(
                          height: 3.w,
                        ),
                        _buildText("ALREADY HAVE AN ACCOUNT?", " LOGIN HERE !",
                            () {
                          Navigator.pushNamed(context, ScreenRoutes.userLogin);
                        }),
                        SizedBox(
                          height: 5.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildfNameTextField(
      String text,
      TextEditingController controller,
      TextInputType inputType,
      String value,
      String? Function(String?) validator) {
    return Container(
      padding: EdgeInsets.only(left: 3.w, right: 3.w),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
          color: Colors.grey[600]?.withOpacity(0.3)),
      child: TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          keyboardType: inputType,
          validator: validator,
          onSaved: (newValue) => value,
          decoration: InputDecoration(
            hintText: text,
            border: InputBorder.none,
          )),
    );
  }

  Widget _buildPhone(String prefix) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
          color: Colors.grey[600]?.withOpacity(0.3)),
      child: Row(children: [
        SizedBox(width: 4.w),
        Text(
          prefix,
          style: TextStyle(fontSize: 10.sp),
        ),
        SizedBox(
          width: 3.w,
        ),
        Container(
          height: 6.w,
          width: 0.5.w,
          color: Colors.blueAccent,
        ),
        SizedBox(
          width: 6.w,
        ),
        SizedBox(
          width: 40.w,
          child: TextFormField(
            controller: _phoneController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: "Phone",
              counterText: "",
              border: InputBorder.none,
            ),
            validator: (value) =>
                UserInfo.phoneValidator(_phoneController.text),
            onSaved: (newValue) => _phoneController.text,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
          size: 7.w,
        ),
        SizedBox(
          width: 3.w,
        ),
      ]),
    );
  }

  // Widget _buildTerms(UserRegisterViewModel model) {
  //   return Row(
  //     children: [
  //       Checkbox(
  //         activeColor: AppColors.appIconColor,
  //         value: model.isChecked,
  //         onChanged: (value) {
  //           model.setCheckbox(value ?? false);
  //         },
  //       ),
  //       _buildText(
  //           "I accept the Terms and Conditions and", " Privacy Policy", () {})
  //     ],
  //   );
  // }

  Widget _buildButton(String text, UserRegisterViewModel model, context) {
    return GestureDetector(
      onTap: () async {
        // model.check();

        // if (_formKey.currentState?.validate() == true) {
        final result = await model.register(
            _firstNamecontroller.text,
            _lastNameController.text,
            _emailController.text,
            _phoneController.text,
            _passwordController.text);

        if (result != null) {
          print("result =>$result");
          Navigator.pushNamed(context, ScreenRoutes.dashboardScreen,
              arguments: result);
        }
        if (_formKey.currentState?.validate() ?? true) {}
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.w, bottom: 3.w),
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

  Widget _buildPasssword(context, UserRegisterViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 45.w,
          child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                model.setPassword(value);
              },
              keyboardType: TextInputType.visiblePassword,
              decoration: _inputDecoration.copyWith(
                hintText: "Password",
                border: InputBorder.none,
              )),
        ),
        GestureDetector(
          onTap: () {
            String newPassword = password.randomPassword(
                letters: true,
                numbers: true,
                passwordLength: 6,
                uppercase: true);
            model.setPassword(newPassword);
          },
          child: Container(
            padding:
                EdgeInsets.only(top: 3.w, left: 3.w, right: 3.w, bottom: 3.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                color: AppColors.appIconColor),
            child: Text(
              "Generate Password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
        // SizedBox(
        //   width: 2.w,
        // ),
      ],
    );
  }

  final _inputDecoration = InputDecoration(
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.w))));
}
