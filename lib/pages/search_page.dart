import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/data.dart';
import 'package:plaid_test_app/pages/product_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();
  String valueSelected = "New";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultHorizontalPadding),
        child: Column(children: [
          SizedBox(height: 30),
          SearchInput(textEditingController: _textEditingController),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Save search",
                style: TextStyle(color: AppColor.kkBodyColor),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    "New",
                                    "Ending soon",
                                    "Bid only",
                                    "Savage"
                                  ]
                                      .map((e) => ListTile(
                                            onTap: () {
                                              setState(() {
                                                valueSelected = e;
                                              });
                                            },
                                            title: Text(e),
                                          ))
                                      .toList(),
                                ));
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.kkIconBackground,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12),
                        child: Row(children: [
                          Text("Sort"),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            CupertinoIcons.arrowtriangle_down_fill,
                            size: 15,
                          )
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.kkIconBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/view_icon.png",
                        height: 30,
                        width: 30,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.kkIconBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/filter.png",
                        height: 30,
                        width: 30,
                        color: AppColor.kkSecondaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 14,
          ),
          GridView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: firstFour.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // crossAxisSpacing: 12,
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
                        fit: BoxFit.cover,
                        imageUrl: _product.imageUrl.first,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              color:
                                  AppColor.kkPlaceHolderColor.withOpacity(0.4),
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
                          style: TextStyle(color: AppColor.kkSecondaryColor))
                    ]),
                  ),
                );
              }),
        ]),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
    required TextEditingController textEditingController,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
            fillColor: Colors.red,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    _textEditingController.clear();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.kkIconBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        CupertinoIcons.clear,
                        color: AppColor.kkLabelColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  CupertinoIcons.search,
                  size: 32,
                  color: Colors.grey[700],
                )
              ],
            )),
      )),
    ]);
  }
}

var typeList = ["New", "Two", "Three", "Four"];
