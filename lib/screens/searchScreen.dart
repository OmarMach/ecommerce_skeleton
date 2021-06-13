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

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeat,
              image: AssetImage('assets/images/background.jpg'),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade800,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Select categories",
                          style: textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  verticalSeparator,
                  Consumer<SearchProvider>(
                    builder: (context, searchProvider, _) {
                      final selectedFilters = searchProvider.selectedFilters;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: size.height / 3,
                              padding: EdgeInsets.all(10),
                              color: Colors.grey.shade800,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: categoriesProvider
                                    .categories['sub-categories'].length,
                                itemBuilder: (context, index) {
                                  // Selecting a category item.
                                  final currentCatergory = categoriesProvider
                                      .categories['sub-categories']
                                      .elementAt(index);
                                  // Displaying the checkbox Tile
                                  return CheckboxListTile(
                                    activeColor: Colors.green,
                                    value: selectedFilters
                                        .contains(currentCatergory),
                                    onChanged: (value) async {
                                      if (!selectedFilters
                                          .contains(currentCatergory)) {
                                        // Adding the filter to the filters state list.
                                        searchProvider
                                            .addFilter(currentCatergory);
                                        // Performing the fetch request
                                        await searchProvider
                                            .searchForCategorizedProducts(
                                          currentCatergory.id,
                                        );
                                      } else
                                        searchProvider
                                            .removeFilter(currentCatergory);
                                    },
                                    title: Text(
                                      currentCatergory.name,
                                    ),
                                    subtitle: Text(
                                      "${currentCatergory.count} - Product",
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: selectedFilters.isEmpty
                                      ? null
                                      : () async {
                                          // Perform Search Manually for each selected category.
                                          final List<int> categoryIds = [];
                                          selectedFilters.forEach(
                                            (element) {
                                              categoryIds.add(element.id);
                                            },
                                          );
                                          searchProvider
                                              .clearCategorizedProducts();
                                          await searchProvider
                                              .searchProductByCategoriesId(
                                            categoryIds,
                                          );
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
                              // Conditional rendering for the clearing filters Button.
                              if (selectedFilters.isNotEmpty) ...[
                                horizontalSeparator,
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Clearing the state form categorized products and selected filters.
                                    searchProvider.clearFilters();
                                  },
                                  label: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text("Clear filters"),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey.shade800,
                                  ),
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  // Results widget
                  SearchByCategoryResultsWidget(
                    textTheme: textTheme,
                    isLoading: isLoading,
                  )
                ],
              ),
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
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, child) {
        final size = MediaQuery.of(context).size;

        // Getting filtered products from state
        final List<WooProduct> filteringResults =
            searchProvider.categorizedProducts;

        // Calculating pages
        int productsCount = filteringResults.length;
        int pagesCount = productsCount ~/ 10;
        int remainingProductsCount = productsCount % 10;
        // adding one more page if there are less than 10 products in the last page.
        if (remainingProductsCount > 0) pagesCount++;

        // Rendering the results.
        if (filteringResults.isNotEmpty) {
          // if the filtering list is not empty
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(),
              Text(
                "Search results",
                textAlign: TextAlign.center,
                style: widget.textTheme.headline6,
              ),
              Divider(),
              ElevatedButton.icon(
                onPressed: filteringResults.isEmpty
                    ? null
                    : () {
                        searchProvider.clearFilters();
                        page = 0;
                      },
                label: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("Clear results"),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade800,
                ),
                icon: Icon(
                  Icons.delete,
                ),
              ),

              // Displaying loading indicator above the list.
              // If there are products in the list and we're adding more.
              if (searchProvider.isLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: LinearProgressIndicator(),
                  ),
                ),

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
                            filteringResults.sort(
                              (WooProduct a, WooProduct b) =>
                                  a.totalSales.compareTo(b.totalSales),
                            );
                          if (newValue == 'Sort By Latest')
                            filteringResults.sort(
                              (WooProduct a, WooProduct b) =>
                                  a.id.compareTo(b.id),
                            );
                          if (newValue == 'Sort By Title: A to Z')
                            filteringResults.sort(
                              (WooProduct a, WooProduct b) =>
                                  a.name.toLowerCase().compareTo(
                                        b.name.toLowerCase(),
                                      ),
                            );
                          if (newValue == 'Sort By Title: Z to A')
                            filteringResults.sort(
                              (WooProduct a, WooProduct b) =>
                                  b.name.toLowerCase().compareTo(
                                        a.name.toLowerCase(),
                                      ),
                            );
                          if (newValue == 'Sort By Price: Low to High')
                            filteringResults.sort(
                              (WooProduct a, WooProduct b) =>
                                  double.parse(a.price).compareTo(
                                double.parse(b.price),
                              ),
                            );
                          if (newValue == 'Sort By Price: High to Low')
                            filteringResults.sort(
                              (WooProduct a, WooProduct b) =>
                                  double.parse(b.price).compareTo(
                                double.parse(a.price),
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
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width >= 1000
                      ? 5
                      : size.width >= 600
                          ? 3
                          : 2,
                  childAspectRatio: 0.55,
                  mainAxisSpacing: 10,
                ),
                physics: NeverScrollableScrollPhysics(),
                itemCount: page == pagesCount - 1 ? remainingProductsCount : 10,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    product: filteringResults[page * 10 + index],
                  ),
                ),
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
                                width: size.width / 2,
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
                                width: size.width / 2,
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
        } else {
          if (searchProvider.isLoading &&
              searchProvider.selectedFilters.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: LinearProgressIndicator(),
              ),
            );
          } else {
            return Container();
          }
        }
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
