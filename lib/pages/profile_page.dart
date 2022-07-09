import 'package:flutter/material.dart';
import 'package:plaid_test_app/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);

    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.1, 1.2)),
      child: Scaffold(
        body: ProfilePageView(key: key),
      ),
    );
  }
}

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _avatarNameAndAddress(),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }

  Widget _avatarNameAndAddress() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: AppColor.kkIconBackground,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(50),
              color: AppColor.kkInputBackgroundColor,
            ),
            child: Icon(Icons.person_pin),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "John Doery",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "No 8, 2192GX , Allen way, Nigeria",
                    style:
                        TextStyle(fontSize: 12, color: AppColor.kkLabelColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
