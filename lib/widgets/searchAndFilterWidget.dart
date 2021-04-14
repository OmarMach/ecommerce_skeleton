import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/product_category.dart';

import '../utils.dart';

class SearchAndFilterWidget extends StatefulWidget {
  @override
  _SearchAndFilterWidgetState createState() => _SearchAndFilterWidgetState();
}

class _SearchAndFilterWidgetState extends State<SearchAndFilterWidget> {
  final List<WooProductCategory> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    // Getting visual helpers.
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);

    // Mapping the lists from providers.
    final categories = categoriesProvider
        .getAllOnlyCategories()
        .map<DropdownMenuItem<WooProductCategory>>(
          (value) => DropdownMenuItem<WooProductCategory>(
            value: value,
            child: Text(value.name + ' (' + value.count.toString() + ')'),
          ),
        )
        .toList();

    final List<DropdownMenuItem<WooProductCategory>> subCategories =
        categoriesProvider
            .getAllOnlySubCategories()
            .map<DropdownMenuItem<WooProductCategory>>(
              (value) => DropdownMenuItem<WooProductCategory>(
                value: value,
                child: Text(value.name + ' (' + value.count.toString() + ')'),
              ),
            )
            .toList();

    // initialising the dropdown menus initial values..
    WooProductCategory categoryDropDownValue =
        categoriesProvider.getAllOnlyCategories()[0];

    WooProductCategory subCategoryDropDownValue =
        categoriesProvider.getAllOnlySubCategories()[0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        verticalSeparator,
        TextFormField(
          decoration: InputDecoration(
            hintText: "Type product keywords..",
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        verticalSeparator,
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: categories,
          value: categoryDropDownValue,
          onChanged: (WooProductCategory value) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            // checking if the max number of filters has been reached.
            if (selectedFilters.length < 10) {
              // changing the dropdown value.
              categoryDropDownValue = value;

              // checking if that value doesn't exist yet
              if (!selectedFilters.contains(value))
                setState(() {
                  selectedFilters.add(value);
                });
              else
                // Sending message if already exists
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Tha filter is already applied."),
                  ),
                );
            } else
              // Sending message if max filters reached.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("You can select only 10 filters."),
                ),
              );
          },
        ),
        verticalSeparator,
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: subCategories,
          value: subCategoryDropDownValue,
          onChanged: (WooProductCategory value) {
            // clearing any current snackbar
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            // Checking if the max number of fliters has been reached.
            if (selectedFilters.length < 10)
              setState(() {
                // changing dropdown value.
                subCategoryDropDownValue = value;

                // Checking if this filter already exists.
                if (!selectedFilters.contains(value))
                  selectedFilters.add(value);
                else
                  // Sending message if already exists
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Tha filter is already applied."),
                    ),
                  );

                // Sorting the filters by lenght for a better wrapping
                selectedFilters
                    .sort((a, b) => a.name.length.compareTo(b.name.length));
              });
            else
              // Sending message if max filters number has been reached.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("You can select only 10 filters."),
                ),
              );
          },
        ),
        verticalSeparator,
        if (selectedFilters.isNotEmpty)
          Wrap(
            spacing: 10,
            children: [
              // Displaying all the selected filter from previous dropdown buttons as deletable chips.
              ...selectedFilters
                  .map(
                    (e) => Chip(
                      label: Text(e.name),
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
        verticalSeparator,
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
  }
}
