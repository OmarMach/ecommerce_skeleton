import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import '../utils.dart';

class ProductsByCategoryGridListPaginated extends StatefulWidget {
  final int limit;
  const ProductsByCategoryGridListPaginated({
    Key key,
    @required this.categoryId,
    @required this.limit,
  }) : super(key: key);

  final int categoryId;

  @override
  _ProductsByCategoryGridListPaginatedState createState() =>
      _ProductsByCategoryGridListPaginatedState();
}

class _ProductsByCategoryGridListPaginatedState
    extends State<ProductsByCategoryGridListPaginated> {
  int page;
  String dropdownValue = 'Sort By Latest';

  final options = <String>[
    'Sort By Popularity',
    'Sort By Latest',
    'Sort By Price: Low to High',
    'Sort By Price: High to Low',
    'Sort By Title: A to Z',
    'Sort By Title: Z to A',
  ];

  @override
  void initState() {
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sliverGridDelegateWithFixedCrossAxisCount =
        SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: size.width >= 1000
          ? 5
          : size.width >= 600
              ? 3
              : 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: widget.categoryId != 0
            ? Provider.of<ProductProvider>(context, listen: false)
                .getProductsByCategory(widget.categoryId)
            : Provider.of<ProductProvider>(context, listen: false)
                .getProductsFromDb(context, limit: 10),
        builder: (context, AsyncSnapshot<List<WooProduct>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            final List<WooProduct> searchedProducts = snapshot.data;

            int productsCount = searchedProducts.length;
            int pagesCount = productsCount ~/ 10;
            int remainingProductsCount = productsCount % 10;

            if (remainingProductsCount > 0) pagesCount++;

            print("productsCount : $productsCount");
            print("pagesCount : $pagesCount");
            print("remainingProductsCount : $remainingProductsCount");

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String newValue) {
                        setState(
                          () {
                            dropdownValue = newValue;

                            if (newValue == 'Sort By Popularity')
                              searchedProducts.sort(
                                (WooProduct a, WooProduct b) =>
                                    a.totalSales.compareTo(b.totalSales),
                              );
                            if (newValue == 'Sort By Latest')
                              searchedProducts.sort(
                                (WooProduct a, WooProduct b) =>
                                    a.id.compareTo(b.id),
                              );
                            if (newValue == 'Sort By Title: A to Z')
                              searchedProducts.sort(
                                (WooProduct a, WooProduct b) =>
                                    a.name.toLowerCase().compareTo(
                                          b.name.toLowerCase(),
                                        ),
                              );
                            if (newValue == 'Sort By Title: Z to A')
                              searchedProducts.sort(
                                (WooProduct a, WooProduct b) =>
                                    b.name.toLowerCase().compareTo(
                                          a.name.toLowerCase(),
                                        ),
                              );
                            if (newValue == 'Sort By Price: Low to High')
                              searchedProducts.sort(
                                (WooProduct a, WooProduct b) =>
                                    a.price.toLowerCase().compareTo(
                                          b.price.toLowerCase(),
                                        ),
                              );
                            if (newValue == 'Sort By Price: High to Low')
                              searchedProducts.sort(
                                (WooProduct a, WooProduct b) =>
                                    b.price.toLowerCase().compareTo(
                                          a.price.toLowerCase(),
                                        ),
                              );
                          },
                        );
                      },
                      selectedItemBuilder: (BuildContext context) {
                        return options.map((String value) {
                          return Center(
                            child: Text(
                              dropdownValue,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList();
                      },
                      items:
                          options.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                verticalSeparator,
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.categoryId == 0
                      ? 10
                      : page == pagesCount - 1
                          ? remainingProductsCount
                          : 10,
                  gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      product: searchedProducts[
                          widget.categoryId == 0 ? index : page * 10 + index],
                    );
                  },
                ),
                if (pagesCount > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: page > 0
                              ? () {
                                  setState(() {
                                    page--;
                                  });
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Material(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_rounded,
                                      color:
                                          page > 0 ? Colors.white : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      for (var i = 0; i < pagesCount; i++)
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                page = i;
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        (i + 1).toString(),
                                        style: TextStyle(
                                          color: page == i
                                              ? Colors.redAccent
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Flexible(
                        child: InkWell(
                          onTap: page < pagesCount - 1
                              ? () {
                                  setState(() {
                                    page++;
                                  });
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Material(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: page < pagesCount - 1
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
