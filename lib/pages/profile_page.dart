import 'package:flutter/material.dart';
import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/global_widgets/avatar_name_email.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);

    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.0, 1.2)),
      child: SafeArea(
        child: Scaffold(
          body: ProfilePageView(key: key),
        ),
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
          avatarNameAndAddress(),
          Divider(
            height: 0,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
                physics: BouncingScrollPhysics(),
                children: ListTile.divideTiles(
                    color: AppColor.kkLabelColor.withOpacity(0.3),
                    tiles: [
                      ListTile(
                        onTap: () {},
                        leading: const Text("Wishlist"),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Text("My order"),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Text("My Orders"),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Text("Delivery Address"),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Text("Gift cards & vouchers"),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Text("Contact preferences"),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      )
                    ]).toList()),
          )
        ],
      ),
    );
  }
}
