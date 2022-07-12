import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/pages/home_page.dart';
import 'package:plaid_test_app/pages/tab_manager.dart';
import 'package:plaid_test_app/text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ));
    return MaterialApp(
      title: 'Open Fashion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: appBarThemeData.copyWith(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0.0),
          scaffoldBackgroundColor: Colors.white,
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.black, unselectedLabelColor: Colors.grey),
          textTheme: appTextTheme),
      routes: {
        TabManagerPage.id: (context) => const TabManagerPage(),
        HomePage.id: (context) => const HomePage(),
      },
      initialRoute: TabManagerPage.id,
    );
  }
}
