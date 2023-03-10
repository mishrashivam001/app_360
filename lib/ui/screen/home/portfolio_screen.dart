// import 'package:app_360/core/router/screen_routes.dart';
import 'package:app_360/controller/view_models/portfolio_view_model.dart';
import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/core/utils/sizer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

import '../../base_view.dart';

class PortFolioScreen extends StatelessWidget {
  PortFolioScreen({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: BaseStatefulView<PortfolioViewModel>(
              loadOnInit: (p0) => p0.init(),
              builder: (context, model, child) {
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
                              color: AppColors.darkSecondaryColor,
                              fontSize: 10.sp),
                        )
                      ],
                    ),
                  );
                }
                if (model.rates == null) {
                  return Padding(
                    padding: EdgeInsets.only(top: 50.w),
                    child: Center(
                        child: Text(
                      'No Data',
                      style: TextStyle(
                          color: AppColors.darkSecondaryColor, fontSize: 14.sp),
                    )),
                  );
                }
                return _buildPortFolioContent(context, model);
              })),
    );
  }

  Widget _buildPortFolioContent(context, PortfolioViewModel model) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 36.8.h,
            padding: EdgeInsets.only(bottom: 10.w),
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/app_bg.png",
                    ),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 3.w),
                  child: Image.network(
                    "${model.rates?.brandImageURL}",
                    color: Colors.white,
                    height: 10.h,
                    // width: double.infinity,
                  ),
                ),
                SizedBox(height: 1.h),
                _buildTextContent("PORTFOLIO", 17.sp, FontWeight.bold, 2.0),
                SizedBox(
                  height: 0.5.h,
                ),
                _buildTextContent("LIVE PORFOLIO PERFORMANCES", 14.sp,
                    FontWeight.normal, 1.0),
                SizedBox(
                  height: 0.3.h,
                ),
                _buildTextContent(
                    "PORTFOLIO: 34785.77", 14.sp, FontWeight.normal, 1.0),
                SizedBox(
                  height: 2.h,
                ),
                _buildSearch(model),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTab(),
                SizedBox(height: 3.w),
                model.load
                    ? SizedBox(
                        height: 30.h,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: model.items?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildListContent(context, model, index);
                        }),
                SizedBox(
                  height: 3.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(
      String text, double size, FontWeight fontWeight, double letterSpacing) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: TextStyle(
          fontSize: size, fontWeight: fontWeight, letterSpacing: letterSpacing),
    );
  }

  Widget _buildSearch(PortfolioViewModel model) {
    return Container(
      margin: EdgeInsets.only(right: 5.w, left: 5.w),
      height: 7.h,
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(left: 6.w, right: 1.w, bottom: 1.w),
              height: 4.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.w)),
                  color: Colors.white),
              child: TextFormField(
                  cursorColor: AppColors.lightOnPrimaryColor,
                  controller: _searchController,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => model.query(value),
                  decoration: InputDecoration(
                    hintText: "Search here",
                    hintStyle: TextStyle(fontSize: 10.sp, color: Colors.black),
                    border: InputBorder.none,
                  )),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Image.asset(
                "assets/search_icon.png",
                height: 7.w,
                width: 7.w,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 3.w,
        ),
        Text(
          "ALLCRYPTO CURRENCY",
          style: TextStyle(fontSize: 9.sp, color: Colors.white),
        ),
        const Spacer(),
        Text(
          "COINS",
          style: TextStyle(fontSize: 9.sp, color: Colors.white),
        ),
        const Spacer(),
        Text(
          "RATES",
          style: TextStyle(fontSize: 9.sp, color: Colors.white),
        ),
        const Spacer(),
        Text(
          "TOTAL VALUE",
          style: TextStyle(fontSize: 9.sp, color: Colors.white),
        ),
        SizedBox(
          width: 3.w,
        ),
      ],
    );
  }

  Widget _buildListContent(
      BuildContext context, PortfolioViewModel model, int index) {
    return Container(
      margin: EdgeInsets.only(top: 2.w),
      decoration: BoxDecoration(
          color: AppColors.rateListbg.withOpacity(0.3),
          borderRadius: BorderRadius.all(Radius.circular(5.w))),
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
          child: Row(
            children: [
              SizedBox(
                width: 3.w,
              ),
              // CircleAvatar(
              //   backgroundImage: const NetworkImage(model.items[index].),
              //   radius: 3.2.h,
              // ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                model.items![index].symbol!,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Spacer(),
              Text(
                "${model.items![index].count}",
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 7.w,
              ),
              Text(
                "\$44849",
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 4.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "\$47823.9",
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1.w),
                  Text(
                    "+3.2%",
                    style: TextStyle(
                        letterSpacing: 2, fontSize: 7.sp, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(width: 1.w),
              CircleAvatar(
                backgroundImage: const AssetImage("assets/delete_icon.png"),
                radius: 1.2.h,
              ),
              SizedBox(width: 2.w),
            ],
          ),
        ),
      ),
    );
  }
}
