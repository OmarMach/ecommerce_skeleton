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
      crossAxisCount: 1,
      childAspectRatio: 5 / 3,
      mainAxisSpacing: 20,
    );

    return SizedBox(
      // Fixing the height of this gridview since it shrink wrap works only on the main axis.
      height: size.height / 2.5,
      child: productsList.isNotEmpty
          ? GridView.builder(
              shrinkWrap: true,
              clipBehavior: Clip.antiAlias,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: productsList.length,
              gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
              itemBuilder: (context, index) {
                return ProductWidget(
                  product: productsList[index],
                );
              },
            )
          : Center(
              child: Text("No products Found.."),
            ),
    );
  }
}
