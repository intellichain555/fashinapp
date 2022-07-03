import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/data.dart';
import 'package:plaid_test_app/global_widgets/app_bar.dart';
import 'package:plaid_test_app/model/product.dart';
import 'package:plaid_test_app/pages/image_preview.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

          // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: defaultHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _productImage(size, context),
                    SizedBox(height: 14),
                    _imageSlideIndicator(),
                    SizedBox(height: 18),
                    _titleAndPrice(),
                    SizedBox(height: 20),
                    _colorAndSize(),
                    SizedBox(height: 40),
                    _material(),
                    SizedBox(height: 20),
                    _care(),
                    SizedBox(height: 20),
                    _similarProduct(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: AppColor.kktTitleActiveColor,
            padding: EdgeInsets.symmetric(
                horizontal: defaultHorizontalPadding + 5, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.add, color: AppColor.kkOffWhiteColor),
                    SizedBox(width: 10),
                    Text(
                      "ADD TO BASKET",
                      style: TextStyle(color: AppColor.kkOffWhiteColor),
                    ),
                  ],
                ),
                Icon(
                  Icons.favorite,
                  color: AppColor.kkOffWhiteColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _similarProduct() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          "YOU MAY ALSO LIKE",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.kktTitleActiveColor),
        ),
        Image.asset("assets/extras/arrow_underline.png"),
        const SizedBox(height: 20),
        SizedBox(
          height: 210,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: firstFour.length,
              itemBuilder: (context, index) {
                var _product = firstFour[index];

                return SizedBox(
                  width: 130,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: _product.imageUrl[0],
                          height: 140,
                          // width: 130,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 130,
                          child: Text(
                            _product.title + "hello elpsds sdjskj",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("\$" + _product.price,
                            style: TextStyle(color: AppColor.kkSecondaryColor))
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  _careDetails() {
    return Column(
      children: _careData
          .map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(children: [
                  Image.asset(
                    e[0],
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    e[1],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ]),
              ))
          .toList(),
    );
  }

  _material() {
    return ExpansionTile(
      iconColor: AppColor.kkSecondaryColor,
      title: Text(
        "MATERIAL",
        style: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products.",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColor.kkLabelColor),
            )
          ],
        ),
      ],
    );
  }

  _care() {
    return ExpansionTile(
      title: Text(
        "CARE",
        style: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "To keep your jackets and coats clean, you only need to freshen them up and go over them with a cloth or a clothes brush. If you need to dry clean a garment, look for a dry cleaner that uses technologies that are respectful of the environment.",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColor.kkLabelColor),
            ),
            SizedBox(height: 20),
            _careDetails()
          ],
        ),
      ],
    );
  }

  _colorAndSize() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Color",
              style: TextStyle(
                  color: AppColor.kkLabelColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 8,
            ),
            Row(
              children: product.colors!
                  .map((e) => Container(
                        decoration: BoxDecoration(
                            color: e,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 3,
                                color: AppColor.kkPlaceHolderColor
                                    .withOpacity(0.9))),
                        child: Container(
                          decoration: BoxDecoration(
                              color: e,
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                          height: 20,
                          width: 20,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Size",
              style: TextStyle(
                  color: AppColor.kkLabelColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 8,
            ),
            Row(
              children: product.sizes!
                  .map((e) => Container(
                        decoration: BoxDecoration(
                          color: AppColor.kkBodyColor,
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(50),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          e.toUpperCase(),
                          style:
                              TextStyle(color: AppColor.kkInputBackgroundColor),
                        ),
                      ))
                  .toList(),
            ),
          ],
        )
      ],
    );
  }

  Widget _titleAndPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.brandName,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 4),
            ),
            Image.asset(
              "assets/icons/arrow_share.png",
              height: 25,
              width: 25,
            )
          ],
        ),
        SizedBox(height: 8),
        Text(
          product.title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.kkLabelColor),
        ),
        SizedBox(height: 8),
        Text(
          "\$" + product.price,
          style: TextStyle(
              color: AppColor.kkSecondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  SingleChildScrollView _imageSlideIndicator() {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ["All", "Apparel", "Dress", "Tshirt", "Bag"]
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Material(
                    color: AppColor.kkPlaceHolderColor,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Stack _productImage(Size size, BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
            height: size.height * 0.5,
            width: double.infinity,
            child: PageView.builder(
                itemCount: product.imageUrl.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: product.imageUrl[0],
                    fit: BoxFit.contain,
                  );
                })),
        Positioned(
          bottom: 18,
          right: 20,
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      insetPadding: EdgeInsets.only(top: _size.height * 0.08),
                      alignment: Alignment.topCenter,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        height: _size.height * 0.5,
                        width: _size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.imageUrl.length,
                            itemBuilder: (context, index) {
                              var image = product.imageUrl[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  fit: BoxFit.contain,
                                ),
                              );
                            }),
                      ),
                    );
                  });

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ImagePreview(
              //               url: product.imageUrl,
              //             )));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.kktTitleActiveColor.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset(
                  "assets/icons/expand.png",
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

var _careData = [
  ["assets/icons/bleach.png", "Do not bleach"],
  ["assets/icons/tumble_dry.png", "Do not tumble dry"],
  ["assets/icons/dry_clean.png", "Dry clean with tetrachloroethylene"]
];
