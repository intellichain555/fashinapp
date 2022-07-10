import 'package:flutter/material.dart';
import 'package:plaid_test_app/constants.dart';

Widget avatarNameAndAddress() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20),
    color: AppColor.kkIconBackground,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 40,
          foregroundImage: AssetImage("assets/cloth/portrait/4.png"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Anike Zazu",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "zazu_anike@hotmail.com",
                  style: TextStyle(fontSize: 12, color: AppColor.kkLabelColor),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
