import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/data/models/login_model.dart';
import 'package:app_360/ui/screen/home/charts_screen.dart';
import 'package:app_360/ui/screen/home/portfolio_screen.dart';
import 'package:app_360/ui/screen/home/rates_screen.dart';
import 'package:flutter/material.dart';

class MyDashboard extends StatefulWidget {
  final LoginData data;
  const MyDashboard({Key? key, required this.data}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyDashboard> {
  int pageIndex = 0;
  final pages = [RatesScreen(), PortFolioScreen(), const ChartsScreen()];
  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/rates_icon.png"),
              size: 45,
            ),
            label: "Rates"),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/portfolio_icon.png"), size: 45),
            label: "Portfolio"),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/chart_icon.png"), size: 45),
            label: "Charts"),
      ],
      currentIndex: pageIndex,
      selectedItemColor: AppColors.appIconColor,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      onTap: _onItemTapped,
    );
  }
}
