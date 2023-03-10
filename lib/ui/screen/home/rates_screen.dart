import 'package:app_360/controller/view_models/rate_view_model.dart';
import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/core/utils/sizer.dart';
import 'package:app_360/data/models/rate_list_model.dart';
import 'package:app_360/ui/screen/custom/custom_dialog.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';

class RatesScreen extends StatelessWidget {
  RatesScreen({super.key});

  List<RateListData> rateData = [];
  List<RateListData> searchList = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black, body: _buildRatesContent(context)));
  }

  Widget _buildRatesContent(context) {
    return BaseStatefulView<RatesViewModel>(
        loadOnInit: (model) => model.init(),
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
                        color: AppColors.darkSecondaryColor, fontSize: 10.sp),
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
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 27.h,
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
                          model.rates!.brandImageURL!,
                          color: Colors.white,
                          height: 10.h,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      _buildTextContent("${model.rates?.brandName}", 17.sp,
                          FontWeight.bold, 2.0),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      _buildSearch(model),
                    ],
                  ),
                ),
                model.isLoadingChart
                    ? SizedBox(
                        height: 30.h,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTab(),
                            SizedBox(height: 3.w),
                            if (model.rateList?.isNotEmpty == true)
                              ListView.builder(
                                  itemCount: model.rateList!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildListContent(
                                        context, model, index);
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
        });
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

  Widget _buildSearch(RatesViewModel model) {
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
                  textInputAction: TextInputAction.search,
                  cursorColor: AppColors.lightOnPrimaryColor,
                  controller: _controller,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (string) {
                    model.query(string);
                    // searchList.forEach((rateList) {
                    //   if (rateList.symbol.contains(_controller.text))
                    //     rateData.add(rateList);
                    // });
                  },
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
          "CRYPTO CURRENCY",
          style: TextStyle(fontSize: 9.sp, color: Colors.white),
        ),
        const Spacer(),
        Text(
          "RATES",
          style: TextStyle(fontSize: 9.sp, color: Colors.white),
        ),
        const Spacer(),
        Text(
          "DAILY EXCHANGE",
          style: TextStyle(fontSize: 9.sp, color: Colors.white),
        ),
        SizedBox(
          width: 3.w,
        ),
      ],
    );
  }

  Widget _buildListContent(
      BuildContext context, RatesViewModel model, int index) {
    return Container(
      margin: EdgeInsets.only(top: 2.w),
      decoration: BoxDecoration(
          color: AppColors.rateListbg.withOpacity(0.3),
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
          border: Border.all(width: 0.0)),
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
          child: Row(
            children: [
              SizedBox(
                width: 3.w,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage("${model.rateList![index].img}"),
                radius: 3.2.h,
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                model.rateList![index].symbol!,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Spacer(),
              Text(
                "\$ ${model.rateList![index].rate!.toUpperCase()}",
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model.rateList![index].priceChange24h!,
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1.w),
                  Text(
                    "${model.rateList![index].priceChangePercentage24h} %",
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 7.sp,
                        color: getColor(
                            model.rateList?[index].priceChangePercentage24h)),
                  ),
                ],
              ),
              SizedBox(width: 3.w),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog(
                            title: model.rateList![index].symbol!.toUpperCase(),
                            image: model.rateList![index].img!,
                            description: model.rateList![index].rate!);
                      });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.appIconColor,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.only(
                      top: 2.w, left: 2.w, right: 2.w, bottom: 2.5.w),
                  child: Text(
                    "+",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(String? value) {
    if (value == null) return Colors.red;
    if (value.contains("-")) return Colors.red;
    return Colors.green;
  }
}
