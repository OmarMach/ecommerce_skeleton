import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/utils.dart';
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                verticalSeparator,
                Text(
                  "Search Products..",
                  style: textTheme.headline4,
                ),
                SearchAndFilterWidget(),
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
