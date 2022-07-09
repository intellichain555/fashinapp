import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/global_widgets/app_bar.dart';
import 'package:plaid_test_app/pages/home_page.dart';
import 'package:plaid_test_app/pages/profile_page.dart';
import 'package:plaid_test_app/pages/search_page.dart';

class TabManagerPage extends StatefulWidget {
  static String id = "TabManagerPage";
  const TabManagerPage({Key? key}) : super(key: key);

  @override
  State<TabManagerPage> createState() => _TabManagerPageState();
}

class _TabManagerPageState extends State<TabManagerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(),
        appBar: 'a' == "a"
            ? customAppBar(
                onTapOnLeading: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            : SizedBox.shrink(),
        body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
          HomePage(
            onDrawerCalled: _onDrawerCalled,
          ),
          SearchPage(),
          ProfilePage(),
        ]),
        bottomNavigationBar: TabBar(
            labelColor: AppColor.kkSecondaryColor,
            labelStyle: TextStyle(fontSize: 12),
            indicator: BoxDecoration(),
            tabs: [
              Tab(
                icon: Icon(CupertinoIcons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(CupertinoIcons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(CupertinoIcons.person_solid),
                text: "Profile",
              ),
            ]),
      ),
    );
  }

  _onDrawerCalled() {
    Scaffold.of(context).openDrawer();
  }
}
