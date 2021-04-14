import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/providers/searchProvider.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/filterOnlyWidget.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:ecommerce_app/widgets/searchAndFilterWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/products.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<WooProductCategory> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    // Getting visual helpers.
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildAppBarSpacer(size),
                verticalSeparator,
                Text(
                  "Select categories",
                  style: textTheme.headline6,
                ),
                Consumer<SearchProvider>(
                  builder: (context, searchProvider, _) {
                    final selectedFilters = searchProvider.selectedFilters;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: size.height / 3,
                          padding: EdgeInsets.all(10),
                          color: Colors.grey.shade800,
                          child: ListView.builder(
                            itemCount:
                                categoriesProvider.grouppedCategories.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final currentCatergory = categoriesProvider
                                  .grouppedCategories
                                  .elementAt(index);

                              return CheckboxListTile(
                                activeColor: Colors.green,
                                value:
                                    selectedFilters.contains(currentCatergory),
                                onChanged: (value) {
                                  if (!selectedFilters
                                      .contains(currentCatergory))
                                    searchProvider.addFilter(currentCatergory);
                                  else
                                    searchProvider
                                        .removeFilter(currentCatergory);
                                  setState(() {});
                                },
                                title: Text(
                                  currentCatergory.name,
                                ),
                                subtitle: Text("items  : " +
                                    currentCatergory.count.toString()),
                              );
                            },
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              searchProvider.addAll(
                                  categoriesProvider.grouppedCategories);
                            });
                          },
                          label: Text("select all"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade800,
                          ),
                          icon: Icon(Icons.add_box_sharp),
                        ),
                        ElevatedButton.icon(
                          onPressed: selectedFilters.isEmpty
                              ? null
                              : () {
                                  setState(() {
                                    searchProvider.clearFilters();
                                  });
                                },
                          label: Text("Clear filters"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade800,
                          ),
                          icon: Icon(Icons.delete),
                        ),
                        ElevatedButton.icon(
                          onPressed: selectedFilters.isEmpty
                              ? null
                              : () {
                                  final List<int> categoryIds = [];
                                  selectedFilters.forEach(
                                    (element) {
                                      categoryIds.add(element.id);
                                    },
                                  );
                                  productsProvider.searchProductsByFilters(
                                    categoriesId: categoryIds,
                                  );
                                  setState(() {});
                                },
                          label: Text("Search"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade800,
                          ),
                          icon: Icon(Icons.search_rounded),
                        ),
                      ],
                    );
                  },
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Search results",
                    textAlign: TextAlign.center,
                    style: textTheme.headline6,
                  ),
                ),
                Divider(),
                Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    final List<WooProduct> searchedProducts =
                        productProvider.filteredProducts;

                    return Container(
                      width: size.width * .9,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.55,
                          mainAxisSpacing: 10,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: searchedProducts.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductWidget(
                            product: searchedProducts[index],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
