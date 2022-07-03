import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plaid_test_app/global_widgets/app_bar.dart';
import 'package:plaid_test_app/pages/home_page.dart';
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
      length: 4,
      child: Scaffold(
        appBar: customAppBar(
          onTapOnLeading: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        body: TabBarView(children: [
          HomePage(),
          SearchPage(),
          Scaffold(),
          Scaffold(),
        ]),
        bottomNavigationBar: TabBar(indicator: BoxDecoration(), tabs: [
          Tab(
            icon: Icon(
              CupertinoIcons.home,
            ),
          ),
          Tab(
            icon: Icon(CupertinoIcons.search),
          ),
          Tab(
            icon: Icon(CupertinoIcons.home),
          ),
          Tab(
            icon: Icon(CupertinoIcons.home),
          ),
        ]),
      ),
    );
  }
}
