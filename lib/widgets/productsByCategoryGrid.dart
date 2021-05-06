import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import '../utils.dart';

class ProductsByCategoryGridList extends StatelessWidget {
  final int limit;
  final int categoryId;

  const ProductsByCategoryGridList({
    Key key,
    @required this.limit,
    @required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliverGridDelegateWithFixedCrossAxisCount =
        SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );

    return FutureBuilder(
      future: categoryId != 0
          ? Provider.of<ProductProvider>(context, listen: false)
              .getProductsByCategory(categoryId)
          : Provider.of<ProductProvider>(context, listen: false)
              .getProductsFromDb(context, limit: 10),
      builder: (context, AsyncSnapshot<List<WooProduct>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          final List<WooProduct> searchedProducts = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              verticalSeparator,
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: limit > searchedProducts.length
                    ? searchedProducts.length
                    : limit,
                gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
                itemBuilder: (context, index) {
                  return ProductWidget(
                    product: searchedProducts[index],
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
