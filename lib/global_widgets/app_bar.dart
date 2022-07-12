import 'package:flutter/material.dart';
import '../constants.dart';

customAppBar({void Function()? onLeadingPressed}) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColor.kkOffWhiteColor,
    leading: IconButton(
      onPressed: onLeadingPressed,
      icon: Image.asset(
        'assets/icons/menuicon.png',
        height: 25,
        width: 20,
      ),
    ),
    title: Image.asset("assets/icons/Logo.png"),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {},
        icon: Image.asset(
          'assets/icons/shopping bagicon.png',
          height: 25,
          width: 20,
        ),
      ),
    ],
  );
}
