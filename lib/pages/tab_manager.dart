import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plaid_test_app/constants.dart';
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
    var query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.0, 1.2)),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
            HomePage(),
            const SearchPage(),
            const ProfilePage(),
          ]),
          bottomNavigationBar: const TabBar(
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
      ),
    );
  }

  _onDrawerCalled() {
    Scaffold.of(context).openDrawer();
  }
}
