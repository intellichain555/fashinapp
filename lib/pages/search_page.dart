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

  late FocusNode searchInputFocusNode;
  @override
  void initState() {
    super.initState();
    layoutViewTypeBloc = LayoutViewTypeBloc();
    searchInputFocusNode = FocusNode();
    _textEditingController.text = "Dress";
  }

  String selectedDropDownValue = "New";
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);

    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.1, 1.2)),
      child: Scaffold(
        endDrawer: endFilterDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultHorizontalPadding),
          child: GestureDetector(
            onTap: () {
              searchInputFocusNode.unfocus();
            },
            child: Column(children: [
              const SizedBox(height: 55),
              SearchInput(
                textEditingController: _textEditingController,
                searchInputFocusNode: searchInputFocusNode,
              ),
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
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      child: state.viewType == LayoutView.grid
                          ? const GridLayout()
                          : ListLayout(),
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Drawer endFilterDrawer() {
    return Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 55),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text("Filter",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Reset",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Sort"),
                  ),
                  Row(
                    children: [
                      Text("Best Match"),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Buying format"),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, size: 20),
                        onPressed: () {},
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        "All listing",
                        "Auction",
                        "New released",
                        "Latest"
                      ]
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.kkPlaceHolderColor
                                          .withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 6.0),
                                    child: Text(e),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Sort"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Condition"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Price"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Category"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Subject"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Image Color"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Item location"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Delivery options"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            CustomWidgetWithLowerBottomBorder(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Customise"),
                    Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: AppColor.kkLabelColor,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomWidgetWithLowerBottomBorder extends StatelessWidget {
  final Widget child;

  const CustomWidgetWithLowerBottomBorder({Key? key, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: AppColor.kkLabelColor.withOpacity(0.2)))),
      child: child,
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColor.kkIconBackground,
                  borderRadius: BorderRadius.circular(20)),
              height: 42,
              child: FittedBox(
                fit: BoxFit.contain,
                child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    alignment: Alignment.center,
                    borderRadius: BorderRadius.circular(20),
                    elevation: 2,
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
                          ? "assets/icons/view_icon.png"
                          : "assets/icons/grid_view.png",
                      height: 30,
                      width: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
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
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                color: AppColor.kkPlaceHolderColor
                                    .withOpacity(0.4),
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, string, dyn) =>
                              Icon(Icons.error),
                        ),
                        Positioned(
                            left: 0,
                            bottom: 0,
                            child: Container(
                              color: AppColor.kkOffWhiteColor,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  _product.brandName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                      ],
                    )),
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        _product.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text("\$" + _product.price,
                        style: TextStyle(
                            color: AppColor.kkSecondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700))
                  ]),
            ),
          );
        });
  }
}

class SearchInput extends StatelessWidget {
  SearchInput({
    Key? key,
    required this.searchInputFocusNode,
    required TextEditingController textEditingController,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final TextEditingController _textEditingController;
  FocusNode searchInputFocusNode;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: TextField(
        controller: _textEditingController,
        focusNode: searchInputFocusNode,
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
