import 'package:flutter/material.dart';
import 'package:news_app/Tabs/fav_tav.dart';
import 'package:news_app/Tabs/home_tab.dart';
import 'package:news_app/Tabs/profile_tab.dart';
import 'package:news_app/Tabs/search_tab.dart';
import 'package:news_app/screens/Favourite_login.dart';
import 'package:news_app/widgets/bottom_tabs.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _tabpageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabpageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabpageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _tabpageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  FavourtieTab(),
                  ProflieTab(),
                ],
              ),
            ),
            BottomTabs(
              selectedTab: _selectedTab,
              tabpressed: (num) {
                _tabpageController.animateToPage(num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              },
            ),
          ],
        ),
      ),
    );
  }
}
