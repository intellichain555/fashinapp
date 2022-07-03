import 'package:flutter/material.dart';
import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/data.dart';

class Product {
  final String brandName;
  final String title;
  final String price;

  final List<Color> colors;
  List<String> sizes;

  final String? material;
  final String? care;

  ///icon ,text
  final List careListWithIcon = [
    ['assets/sd/cdskd', 'Do not bleach'],
    ["asses/sds/sdsd", "Do not tumble dry"],
  ];

  /// 19/06/2022 - 20/06/2022
  final String? estimatedDeliveryDate;
  final String? codPolicy;
  final String? returnPolicy;
  final List<String> imageUrl;

  Product({
    required this.imageUrl,
    required this.brandName,
    required this.title,
    required this.price,
    this.colors = const [Color(0xFF0F140D), AppColor.kkSecondaryColor],
    this.sizes = const ["S", "M", "L"],
    this.material,
    this.care,
    this.estimatedDeliveryDate,
    this.codPolicy,
    this.returnPolicy,
  });
}
