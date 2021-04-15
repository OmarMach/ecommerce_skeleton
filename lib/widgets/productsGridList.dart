import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGridList extends StatelessWidget {
  const ProductsGridList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsList =
        Provider.of<ProductProvider>(context, listen: false).items;

    final size = MediaQuery.of(context).size;

    const sliverGridDelegateWithFixedCrossAxisCount =
        SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
    );

    return productsList.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            clipBehavior: Clip.antiAlias,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
            itemBuilder: (context, index) {
              return ProductWidget(
                product: productsList[index],
              );
            },
          )
        : Center(
            child: Text("No products Found.."),
          );
  }
}
