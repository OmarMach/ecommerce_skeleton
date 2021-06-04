import 'package:ecommerce_app/providers/searchProvider.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import '../utils.dart';

class ProductsByCategoryGridListPaginated extends StatefulWidget {
  const ProductsByCategoryGridListPaginated({
    Key key,
    @required this.categoryId,
    @required this.limit,
  }) : super(key: key);

  final int limit;
  final int categoryId;

  @override
  _ProductsByCategoryGridListPaginatedState createState() =>
      _ProductsByCategoryGridListPaginatedState();
}

class _ProductsByCategoryGridListPaginatedState
    extends State<ProductsByCategoryGridListPaginated> {
  int page;

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
      child: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) {
          final List<WooProduct> searchedProducts =
              searchProvider.searchedProducts;

          int productsCount = searchedProducts.length;
          int pagesCount = productsCount ~/ 10;
          int remainingProductsCount = productsCount % 10;

          if (remainingProductsCount > 0) pagesCount++;
          if (searchProvider.searchedProducts.isEmpty)
            searchProvider.searchProductsByCategory(0);

          // if (searchProvider.searchedProducts.isEmpty) {
          //   return FutureBuilder(
          //     future: searchProvider.searchProductsByCategory(0),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       } else {
          //         return Container();
          //       }
          //     },
          //   );
          // } else
          if (searchProvider.searchedProducts.isEmpty)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sorting dropdown menu.
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
                    hint: Text("Sort By"),
                    value: searchProvider.sortValue,
                    onChanged: (String newValue) {
                      searchProvider.sortSearchedProducts(newValue);
                    },
                    items: mappedSortingListItems,
                  ),
                ),
              ),

              // Displaying the list of items
              verticalSeparator,
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: page == pagesCount - 1 ? remainingProductsCount : 10,
                gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
                itemBuilder: (context, index) {
                  return ProductWidget(
                    product: searchedProducts[page * 10 + index],
                  );
                },
              ),

              // pagination controls
              if (pagesCount > 1)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: page > 0
                            ? () {
                                setState(() {
                                  page--;
                                });
                              }
                            : null,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: page > 0 ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                    horizontalSeparator,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: page < pagesCount - 1
                            ? () {
                                setState(() {
                                  page++;
                                });
                              }
                            : null,
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: page < pagesCount - 1
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
