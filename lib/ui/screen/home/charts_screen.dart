import 'package:app_360/controller/view_models/chart_screen_viewmodel.dart';
import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/core/utils/sizer.dart';
import 'package:app_360/data/models/chart_list_model.dart';
// import 'package:app_360/data/models/user_register_model.dart';
// import 'package:app_360/data/models/user_register_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../base_view.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _buildChartsContent(context),
      ),
    );
  }

  Widget _buildChartsContent(context) {
    return BaseStatefulView<ChartsScreenViewModel>(
        loadOnInit: (p0) => p0.init(),
        builder: (context, model, child) {
          if (model.loading) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   height: 27.h,
                  //   width: double.infinity,
                  //   decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/app_bg.png"),
                  //         fit: BoxFit.fill),
                  //   ),
                  // ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 27.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/app_bg.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3.w),
                        child: Image.network(
                          model.rates?.brandImageURL ?? '',
                          color: Colors.white,
                          height: 10.h,
                          // width: double.infinity,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      _buildTextContent("${model.rates?.brandName}", 20.sp,
                          FontWeight.bold, 2.0),
                      SizedBox(
                        height: 2.h,
                      ),
                      _buildDropDown(model),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.w, right: 5.w, left: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      _buildTextContent(
                          "EXCHANGE RATE", 20.sp, FontWeight.bold, 0.0),
                      _buildCharts(model),
                      // _buildTextContent(
                      //     "Total Visitors", 13.sp, FontWeight.normal, 0.0),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     _buildTextContent("0", 30.sp, FontWeight.bold, 0.0),
                      //     Container(
                      //       padding: EdgeInsets.only(
                      //           top: 3.w, left: 5.w, right: 5.w, bottom: 3.w),
                      //       color: AppColors.appIconColor,
                      //       child: Text(
                      //         "More",
                      //         style: TextStyle(
                      //           fontSize: 11.sp,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.w,
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
          color: Colors.white,
          fontSize: size,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing),
    );
  }

  Widget _buildDropDown(ChartsScreenViewModel model) {
    if (model.symbolList == null || model.selectCurrency == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.only(left: 5.w, right: 5.w),
      height: 12.w,
      padding: EdgeInsets.only(left: 3.w, right: 3.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(2.w)),
      ),
      child: DropdownButton<String>(
        style: const TextStyle(color: Colors.black),
        underline: const SizedBox.shrink(),
        value: model.selectCurrency,
        isExpanded: true,
        hint: const Text(
          'Select Item',
          style: TextStyle(color: Colors.black),
        ),
        items: model.symbolList!
            .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e.toUpperCase(),
                      style: const TextStyle(color: Colors.black)),
                ))
            .toList(),
        onChanged: (String? value) {
          model.setSelected(value);
          // model.setLoading();
          // _buildCharts(model);
        },
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildCharts(ChartsScreenViewModel model) {
    if (model.isLoadingChart) {
      return SizedBox(
        height: 30.h,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }
    if (model.chartList == null) return const SizedBox.shrink();

    return SizedBox(
      height: 30.h,
      width: double.infinity,
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          enableAxisAnimation: true,
          onPlotAreaSwipe: (direction) => ChartSwipeDirection.end,
          selectionType: SelectionType.point,
          zoomPanBehavior:
              ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.xy),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<ChartListData, String>>[
            SplineAreaSeries<ChartListData, String>(
              dataSource: model.chartList!,
              xValueMapper: (ChartListData sales, int index) {
                int timestamp = sales.i0!;
                DateTime tsdate =
                    DateTime.fromMillisecondsSinceEpoch(timestamp);
                return DateFormat("HH:mm").format(tsdate);
              },
              yValueMapper: (ChartListData sales, int index) => sales.d1,
              color: AppColors.appIconColor,
              gradient: LinearGradient(
                colors: [
                  AppColors.appIconColor,
                  AppColors.appIconColor.withOpacity(0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ]),
    );
  }
}
