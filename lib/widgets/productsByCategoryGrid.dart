import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsByCategoryGridList extends StatelessWidget {
  const ProductsByCategoryGridList({
    Key key,
    @required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    final categoryProductList =
        Provider.of<ProductProvider>(context, listen: false).items;
    final size = MediaQuery.of(context).size;
    final sliverGridDelegateWithFixedCrossAxisCount =
        SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 5 / 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );

    return categoryProductList.isNotEmpty
        ? SizedBox(
            height: size.height / 2.5,
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: categoryProductList.length,
              gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
              itemBuilder: (context, index) {
                return ProductWidget(product: categoryProductList[index]);
              },
            ),
          )
        : Center(
            child: Text("No products Found.."),
          );
  }
}
