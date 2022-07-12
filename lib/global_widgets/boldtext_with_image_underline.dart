import 'package:flutter/material.dart';
import '../constants.dart';

boldTextWithImageUnderline({required String title}) {
  return Column(
    children: [
      SizedBox(height: 30),
      Text(
        "NEW ARRIVAL",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.kktTitleActiveColor),
      ),
      Image.asset("assets/extras/s.png"),
    ],
  );
}
