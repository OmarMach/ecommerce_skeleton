import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/providers/searchProvider.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
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
                    "Keywords",
                    style: textTheme.headline6,
                  ),
                ),
                TextFormField(
                  controller: _keywordsController,
                  decoration: buildFormInputDecoration(
                    icon: Icons.search,
                    label: 'Keywords..',
                  ),
                ),
                verticalSeparator,
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
                                      .contains(currentCatergory))
                                    searchProvider.addFilter(currentCatergory);
                                  else
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
                                                categoryIds);
                                        searchProvider.clearSearchedProducts();
                                      },
                                label: Text("Search"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey.shade800,
                                ),
                                icon: Icon(Icons.search_rounded),
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
                Consumer<SearchProvider>(
                  builder: (context, searchProvider, child) {
                    final List<WooProduct> searchedProducts =
                        searchProvider.searchedProducts;
                    print(searchProvider.isLoading);
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
                                  style: textTheme.headline6,
                                ),
                              ),
                              Divider(),
                              ElevatedButton.icon(
                                onPressed: searchProvider
                                        .searchedProducts.isEmpty
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
                              GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
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
                            ],
                          )
                        : searchProvider.isLoading
                            ? Container(
                                child: CircularProgressIndicator(),
                              )
                            : Container();
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
