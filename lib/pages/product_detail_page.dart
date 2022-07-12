import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/data.dart';
import 'package:plaid_test_app/model/product.dart';
import 'package:plaid_test_app/pages/bloc/image_indicator/cubit/image_indicator_cubit.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ImageIndicatorCubit(),
        child: ProductDetailBody(product: product));
  }
}

class ProductDetailBody extends StatelessWidget {
  Product product;
  ProductDetailBody({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.0, 1.2)),
      child: Scaffold(
          appBar: AppBar(

              // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _productImage(size, context),
                        SizedBox(height: 14),
                        _imageSlideIndicator(),
                        SizedBox(height: 18),
                        _titleAndPrice(),
                        SizedBox(height: 20),
                        ColorAndSize(product: product),
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
                    horizontal: defaultHorizontalPadding + 5, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
          )),
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
                onPageChanged: (index) {
                  BlocProvider.of<ImageIndicatorCubit>(context)
                      .imageChanged(index);
                },
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: product.imageUrl[0],
                    fit: BoxFit.cover,
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

  Widget _imageSlideIndicator() {
    return BlocBuilder<ImageIndicatorCubit, ImageIndicatorState>(
      builder: (context, state) => SizedBox(
        height: 10,
        child: Center(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: product.imageUrl.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Material(
                    color: state.index == index
                        ? AppColor.kkSecondaryColor
                        : AppColor.kkPlaceHolderColor,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      height: state.index == index ? 12 : 10,
                      width: state.index == index ? 12 : 10,
                    ),
                  ),
                );
              }),
        ),
      ),
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
            Container(
              color: AppColor.kkLineColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.brandName,
                  style: TextStyle(color: AppColor.kkPrimaryColor),
                ),
              ),
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
              fontWeight: FontWeight.w700),
        )
      ],
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
              style: TextStyle(fontSize: 14, color: AppColor.kkLabelColor),
            )
          ],
        ),
      ],
    );
  }

  _care() {
    return ExpansionTile(
      iconColor: AppColor.kkSecondaryColor,
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsPage(product: _product)));
                      },
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
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text("\$" + _product.price,
                              style: TextStyle(
                                  color: AppColor.kkSecondaryColor,
                                  fontWeight: FontWeight.w700))
                        ],
                      ),
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
}

var _careData = [
  ["assets/icons/bleach.png", "Do not bleach"],
  ["assets/icons/tumble_dry.png", "Do not tumble dry"],
  ["assets/icons/dry_clean.png", "Dry clean with tetrachloroethylene"]
];

class ColorAndSize extends StatefulWidget {
  const ColorAndSize({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ColorAndSize> createState() => _ColorAndSizeState();
}

class _ColorAndSizeState extends State<ColorAndSize> {
  int selectedColorIndex = 0;
  int sizeSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
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
              children: widget.product.colors!
                  .map((e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColorIndex =
                                widget.product.colors.indexOf(e);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: e,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: widget.product
                                              .colors[selectedColorIndex] ==
                                          e
                                      ? 3
                                      : 0,
                                  color: widget.product
                                              .colors[selectedColorIndex] ==
                                          e
                                      ? AppColor.kkPlaceHolderColor
                                          .withOpacity(0.9)
                                      : Colors.transparent)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: e,
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(width: 2, color: Colors.white)),
                            height: 23,
                            width: 28,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                          ),
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
              children: widget.product.sizes!
                  .map((e) => GestureDetector(
                        onTap: () {
                          print(e);
                          setState(() {
                            sizeSelectedIndex = widget.product.sizes
                                .indexWhere((element) => e == element);

                            print(sizeSelectedIndex);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.product.sizes[sizeSelectedIndex] == e
                                ? AppColor.kkBodyColor
                                : Colors.grey,
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(50),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            e.toUpperCase(),
                            style: TextStyle(
                                color: AppColor.kkInputBackgroundColor),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        )
      ],
    );
  }
}
//
// _colorAndSize() {
//
// }
