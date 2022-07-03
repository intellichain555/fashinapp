import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Open Fashion',
      theme: ThemeData(
          appBarTheme:
              appBarThemeData.copyWith(backgroundColor: AppColor.kkLabelColor),
          scaffoldBackgroundColor: Colors.white,
          tabBarTheme: TabBarTheme(
              labelColor: Colors.black, unselectedLabelColor: Colors.grey),
          textTheme: appTextTheme),
      routes: {
        TabManagerPage.id: (context) => TabManagerPage(),
        HomePage.id: (context) => const HomePage(),
      },
      initialRoute: TabManagerPage.id,
    );
  }
}

// class FirstPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//
//       home: const HomePage(),
//     );
//   }
// }
