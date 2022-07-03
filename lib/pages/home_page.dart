import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/data.dart';
import 'package:plaid_test_app/global_widgets/app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          drawer: Drawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "NEW ARRIVAL",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColor.kktTitleActiveColor),
                    ),
                    Image.asset("assets/extras/arrow_underline.png"),
                  ],
                ),

                SizedBox(height: 20),
                SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ["All", "Apparel", "Dress", "Tshirt", "Bag"]
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(e),
                                  SizedBox(height: 4),
                                  Material(
                                    color: AppColor.kkSecondaryColor,
                                    shape: BeveledRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),

                SizedBox(height: 30),
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
                                      builder: (context) => ProductDetailsPage(
                                            product: _product,
                                          )));
                            },
                            child: Column(children: [
                              Expanded(
                                  child: CachedNetworkImage(
                                imageUrl: _product.imageUrl.first,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      color: AppColor.kkPlaceHolderColor
                                          .withOpacity(0.4),
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, string, dyn) =>
                                    Icon(Icons.error),
                              )),
                              SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  _product.brandName + " " + _product.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("\$" + _product.price,
                                  style: TextStyle(
                                      color: AppColor.kkSecondaryColor))
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
    );
  }
}
