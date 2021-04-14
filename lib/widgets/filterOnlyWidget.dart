import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/providers/searchProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterOnlyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting visual helpers.
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;
    return Consumer<SearchProvider>(
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
                itemCount: categoriesProvider.grouppedCategories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final currentCatergory =
                      categoriesProvider.grouppedCategories.elementAt(index);

                  return CheckboxListTile(
                    activeColor: Colors.green,
                    dense: true,
                    value: selectedFilters.contains(currentCatergory),
                    onChanged: (value) {
                      if (!selectedFilters.contains(currentCatergory))
                        searchProvider.addFilter(currentCatergory);
                      else
                        searchProvider.removeFilter(currentCatergory);
                    },
                    title: Text(
                      currentCatergory.name,
                    ),
                    subtitle:
                        Text("items  : " + currentCatergory.count.toString()),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                searchProvider.addAll(categoriesProvider.grouppedCategories);
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
                      searchProvider.clearFilters();
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
    );
  }
}
