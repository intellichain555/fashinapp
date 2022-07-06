import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plaid_test_app/constants.dart';
import 'package:plaid_test_app/data.dart';
import 'package:plaid_test_app/pages/bloc/bloc/layout_view_type_bloc.dart';
import 'package:plaid_test_app/pages/bloc/bloc/view_type_enum.dart';
import 'package:plaid_test_app/pages/product_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();

  String valueSelected = "New";
  late LayoutViewTypeBloc layoutViewTypeBloc;
  @override
  void initState() {
    super.initState();
    layoutViewTypeBloc = LayoutViewTypeBloc();
    _textEditingController.text = "Dress";
  }

  String selectedDropDownValue = "New";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultHorizontalPadding),
        child: Column(children: [
          const SizedBox(height: 30),
          SearchInput(textEditingController: _textEditingController),
          const SizedBox(height: 14),
          ResultFilterAndLayoutView(
              selectedDropDownValue: selectedDropDownValue,
              layoutViewTypeBloc: layoutViewTypeBloc),
          const SizedBox(
            height: 14,
          ),
          Expanded(
            child: BlocBuilder<LayoutViewTypeBloc, LayoutViewTypeState>(
              bloc: layoutViewTypeBloc,
              builder: (context, state) {
                return AnimatedSwitcher(
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  duration: const Duration(milliseconds: 600),
                  reverseDuration: const Duration(milliseconds: 600),
                  child: state.viewType == LayoutView.grid
                      ? const GridLayout()
                      : ListLayout(),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class ResultFilterAndLayoutView extends StatelessWidget {
  const ResultFilterAndLayoutView({
    Key? key,
    required this.selectedDropDownValue,
    required this.layoutViewTypeBloc,
  }) : super(key: key);

  final String selectedDropDownValue;
  final LayoutViewTypeBloc layoutViewTypeBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Save search",
          style: TextStyle(color: AppColor.kkBodyColor),
        ),
        Row(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(20),
            //               ),
            //               content: Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   "New",
            //                   "Ending soon",
            //                   "Bid only",
            //                   "Savage"
            //                 ]
            //                     .map((e) => ListTile(
            //                           onTap: () {
            //                             setState(() {
            //                               valueSelected = e;
            //                             });
            //                           },
            //                           title: Text(e),
            //                         ))
            //                     .toList(),
            //               ));
            //         });
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: AppColor.kkIconBackground,
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(
            //           vertical: 8.0, horizontal: 12),
            //       child: Row(children: [
            //         Text("Sort"),
            //         SizedBox(
            //           width: 4,
            //         ),
            //         Icon(
            //           CupertinoIcons.arrowtriangle_down_fill,
            //           size: 15,
            //         )
            //       ]),
            //     ),
            //   ),
            // ),

            Container(
              decoration: BoxDecoration(
                  color: AppColor.kkIconBackground,
                  borderRadius: BorderRadius.circular(20)),
              height: 42,
              child: FittedBox(
                fit: BoxFit.contain,
                child: DropdownButton<String>(
                    alignment: Alignment.center,
                    borderRadius: BorderRadius.circular(0),
                    value: selectedDropDownValue,
                    underline: SizedBox.shrink(),
                    items: dropDownValueList
                        .map((e) => DropdownMenuItem(
                              alignment: Alignment.center,
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (x) {}),
              ),
            ),
            const SizedBox(width: 10),
            BlocBuilder<LayoutViewTypeBloc, LayoutViewTypeState>(
              bloc: layoutViewTypeBloc,
              builder: (context, state) => GestureDetector(
                onTap: () {
                  bool _viewState = state.viewType == LayoutView.grid;

                  layoutViewTypeBloc.add(LayoutViewTypeEvent(
                      viewType:
                          _viewState ? LayoutView.list : LayoutView.grid));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.kkIconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      state.viewType == LayoutView.grid
                          ? "assets/icons/grid_view.png"
                          : "assets/icons/view_icon.png",
                      height: 30,
                      width: 30,
                      color: Colors.grey.shade900,
                    ),
                  ),
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
    );
  }
}

class ListLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemCount: firstFour.length,
        itemBuilder: (context, index) {
          var _product = firstFour[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Material(
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
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        height: 100,
                        width: 80,
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
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_product.brandName,
                                  style: TextStyle(
                                      color: AppColor.kkSecondaryColor)),
                              Text(
                                _product.title,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text("\$" + _product.price,
                                  style: TextStyle(
                                      color: AppColor.kkSecondaryColor)),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          );
        });
  }
}

class GridLayout extends StatelessWidget {
  const GridLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemCount: firstFour.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // crossAxisSpacing: 12,
            // mainAxisSpacing: 12,
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
                  fit: BoxFit.fill,
                  imageUrl: _product.imageUrl.first,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        color: AppColor.kkPlaceHolderColor.withOpacity(0.4),
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, string, dyn) => Icon(Icons.error),
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
        });
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
