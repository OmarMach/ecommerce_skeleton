import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/providers/searchProvider.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
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
  bool isLoading = false;
  final label = "Some Label";
  final dummyList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Getting visual helpers.
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    // Getting the categories
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    // keywords Text Controller
    TextEditingController _keywordsController = TextEditingController();

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select categories",
                    style: textTheme.headline6,
                  ),
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
                                      .contains(currentCatergory)) {
                                    searchProvider.addFilter(currentCatergory);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    searchProvider.searchProductsByCategory(
                                        currentCatergory.id);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else
                                    searchProvider
                                        .removeFilter(currentCatergory);
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
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: selectedFilters.isEmpty
                                    ? null
                                    : () {
                                        final List<int> categoryIds = [];
                                        selectedFilters.forEach(
                                          (element) {
                                            categoryIds.add(element.id);
                                          },
                                        );
                                        searchProvider
                                            .searchProductByCategoriesId(
                                          categoryIds,
                                        );
                                        searchProvider.clearSearchedProducts();
                                      },
                                label: Text("Search"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey.shade800,
                                ),
                                icon: Icon(
                                  Icons.search_rounded,
                                ),
                              ),
                            ),
                            selectedFilters.isNotEmpty
                                ? Row(
                                    children: [
                                      horizontalSeparator,
                                      ElevatedButton.icon(
                                        onPressed: selectedFilters.isEmpty
                                            ? null
                                            : () {
                                                searchProvider.clearFilters();
                                              },
                                        label: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text("Clear filters"),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.grey.shade800,
                                        ),
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                // Results widget
                SearchByCategoryResultsWidget(
                    textTheme: textTheme, isLoading: isLoading)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchByCategoryResultsWidget extends StatefulWidget {
  const SearchByCategoryResultsWidget({
    Key key,
    @required this.textTheme,
    @required this.isLoading,
  }) : super(key: key);

  final TextTheme textTheme;
  final bool isLoading;

  @override
  _SearchByCategoryResultsWidgetState createState() =>
      _SearchByCategoryResultsWidgetState();
}

class _SearchByCategoryResultsWidgetState
    extends State<SearchByCategoryResultsWidget> {
  int page;
  @override
  void initState() {
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, child) {
        final List<WooProduct> searchedProducts =
            searchProvider.searchedProducts;
        int productsCount = searchedProducts.length;
        int pagesCount = productsCount ~/ 10;
        int remainingProductsCount = productsCount % 10;
        if (remainingProductsCount > 0) pagesCount++;

        print("productsCount : $productsCount");
        print("pagesCount : $pagesCount");
        print("remainingProductsCount : $remainingProductsCount");

        return searchedProducts.length > 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Search results",
                      textAlign: TextAlign.center,
                      style: widget.textTheme.headline6,
                    ),
                  ),
                  Divider(),
                  ElevatedButton.icon(
                    onPressed: searchProvider.searchedProducts.isEmpty
                        ? null
                        : () {
                            searchProvider.clearSearchedProducts();
                          },
                    label: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text("Clear results"),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade800,
                    ),
                    icon: Icon(Icons.delete),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text("Previous"),
                          onPressed: page > 0
                              ? () {
                                  setState(() {
                                    page--;
                                  });
                                }
                              : null,
                        ),
                      ),
                      horizontalSeparator,
                      Expanded(
                        child: ElevatedButton(
                          child: Text("Next"),
                          onPressed: page < pagesCount - 1
                              ? () {
                                  setState(() {
                                    page++;
                                  });
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      mainAxisSpacing: 10,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        page == pagesCount - 1 ? remainingProductsCount : 10,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductWidget(
                        product: searchedProducts[page * 10 + index],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text("Previous"),
                          onPressed: page > 0
                              ? () {
                                  setState(() {
                                    page--;
                                  });
                                }
                              : null,
                        ),
                      ),
                      horizontalSeparator,
                      Expanded(
                        child: ElevatedButton(
                          child: Text("Next"),
                          onPressed: page < pagesCount - 1
                              ? () {
                                  setState(() {
                                    page++;
                                  });
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : widget.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container();
      },
    );
  }
}

InputDecoration buildFormInputDecoration({
  IconData icon,
  String hint,
  String label,
}) {
  return InputDecoration(
    suffixIcon: Icon(icon) ?? null,
    hintText: hint ?? '',
    labelText: label ?? '',
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: new OutlineInputBorder(
      borderSide: new BorderSide(),
    ),
  );
}
