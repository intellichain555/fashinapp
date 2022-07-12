import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'pages/home_page.dart';
import 'pages/tab_manager.dart';
import 'text_theme.dart';

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
