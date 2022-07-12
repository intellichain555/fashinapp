import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/data.dart';
import 'package:plaid_test_app/global_widgets/app_bar.dart';
import 'package:plaid_test_app/global_widgets/avatar_name_email.dart';
import 'package:plaid_test_app/global_widgets/boldtext_with_image_underline.dart';
import 'package:plaid_test_app/pages/product_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "Homepage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);

    print("textScaleFactor : ${query.textScaleFactor}");
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return DefaultTabController(
      length: 3,
      child: MediaQuery(
        data: query.copyWith(
            textScaleFactor: query.textScaleFactor.clamp(1.0, 1.2)),
        child: Scaffold(
            key: _key,
            drawer: Drawer(
              child: Column(
                children: [
                  //drawer header
                  DrawerHeader(
                    margin: EdgeInsets.zero,
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 14),
                    child: avatarNameAndAddress(),
                  ),
                  Expanded(
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: drawerInfo
                            .map(
                              (e) => ListTile(
                                onTap: () {},
                                leading: e[0] as Icon,
                                title: Text(
                                  e[1] as String,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                            .toList()),
                  ),

                  //
                ],
              ),
            ),
            appBar: customAppBar(onLeadingPressed: () {
              _key.currentState!.openDrawer();
            }),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  boldTextWithImageUnderline(title: "NEW ARRIVAL"),

                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultHorizontalPadding),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: firstFour.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1 / 1.6,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          var _product = firstFour[index];
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                              product: _product,
                                            )));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: _product.imageUrl.first,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                color: AppColor
                                                    .kkPlaceHolderColor
                                                    .withOpacity(0.4),
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                          errorWidget: (context, string, dyn) =>
                                              const Icon(Icons.error),
                                        ),
                                        Positioned(
                                            left: 0,
                                            bottom: 0,
                                            child: Container(
                                              color: AppColor.kkOffWhiteColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  _product.brandName,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ))
                                      ],
                                    )),
                                    const SizedBox(height: 4),
                                    Text(
                                      _product.title,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Text("\$" + _product.price,
                                        style: const TextStyle(
                                            color: AppColor.kkSecondaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700))
                                  ]),
                            ),
                          );
                        }),
                  )
                  // TabBar(
                  //     enableFeedback: false,
                  //     indicator: BoxDecoration(),
                  //     padding: EdgeInsets.zero,
                  //     unselectedLabelColor: AppColor.kkPlaceHolderColor,
                  //     labelColor: Colors.black,
                  //     isScrollable: false,
                  //     labelStyle: TextStyle(color: Colors.black, fontSize: 12),
                  //     unselectedLabelStyle:
                  //         TextStyle(fontSize: 12, color: Colors.black),
                  //     tabs: ["All", "Apparel", "Men"]
                  //         .map((e) => Tab(text: e))
                  //         .toList())
                ],
              ),
            )),
      ),
    );
  }
}

var drawerInfo = [
  [const Icon(Icons.home), "Home"],
  [const Icon(CupertinoIcons.cube_box), "New collections"],
  [const Icon(Icons.bookmark), "Editor's Picks"],
  [const Icon(Icons.label), "Top Deals"],
  [const Icon(CupertinoIcons.bell_fill), "Notifications"],
  [const Icon(Icons.settings), "Settings"],
];
