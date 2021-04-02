import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/productsGridList.dart';
import 'package:ecommerce_app/widgets/singleProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final categories =
      <String>['Category 1', 'Category 2', 'Category 3', 'Category 4']
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

  final subCategories = <String>[
    'Sub-category 1',
    'Sub-category 2',
    'Sub-category 3',
    'Sub-category 4'
  ]
      .map<DropdownMenuItem<String>>(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  final List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    String categoryDropDownValue = 'Category 1';
    String subCategoryDropDownValue = 'Sub-category 1';

    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                verticalSeparator,
                Text(
                  "Search Products..",
                  style: textTheme.headline4,
                ),
                verticalSeparator,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Type product keywords..",
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                verticalSeparator,
                Row(
                  children: [
                    Flexible(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: categories,
                        value: categoryDropDownValue,
                        onChanged: (value) {
                          if (selectedFilters.length < 10)
                            setState(() {
                              categoryDropDownValue = value;
                              if (!selectedFilters.contains(value))
                                selectedFilters.add(value);
                            });
                        },
                      ),
                    ),
                    if (selectedFilters.length > 0) horizontalSeparator,
                    if (selectedFilters.length > 0)
                      Flexible(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: subCategories,
                          value: subCategoryDropDownValue,
                          onChanged: (value) {
                            if (selectedFilters.length < 10)
                              setState(() {
                                subCategoryDropDownValue = value;
                                selectedFilters.add(value);
                              });
                          },
                        ),
                      ),
                  ],
                ),
                verticalSeparator,
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text("Search"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade800,
                  ),
                  icon: Icon(Icons.search_rounded),
                ),
                verticalSeparator,
                Wrap(
                  spacing: 10,
                  children: [
                    // Displaying all the selected filter from previous dropdown buttons as deletable chips.
                    ...selectedFilters
                        .map(
                          (e) => Chip(
                            label: Text(e),
                            onDeleted: () {
                              setState(() {
                                selectedFilters.remove(e);
                              });
                            },
                          ),
                        )
                        .toList()
                  ],
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
                FutureBuilder(
                  future: productProvider.getProductsFromDb(context),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? Container(
                            width: size.width * .9,
                            child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.55,
                                  mainAxisSpacing: 10,
                                ),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: productProvider.items.length,
                                itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleProductWidget(
                                        product: productProvider.items[index],
                                      ),
                                    )))
                        : Container(
                            width: size.width * .9,
                            child: Center(child: CircularProgressIndicator()),
                          );
                  },
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Similar products",
                    textAlign: TextAlign.start,
                    style: textTheme.headline6,
                  ),
                ),
                Divider(),
                ProductsGridList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
