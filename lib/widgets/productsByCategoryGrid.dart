import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsByCategoryGridList extends StatelessWidget {
  const ProductsByCategoryGridList({
    Key key,
    @required this.categoryId,
  }) : super(key: key);

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final categoryProductList =
        Provider.of<ProductProvider>(context, listen: false).getProductsByCategory(categoryId);

    final sliverGridDelegateWithFixedCrossAxisCount =
        SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 5 / 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );

    return SizedBox(
      height: size.height / 2.5,
      child: categoryProductList.isNotEmpty
          ? GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: categoryProductList.length,
              gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
              itemBuilder: (context, index) {
                return ProductWidget(product: categoryProductList[index]);
              },
            )
          : Center(
              child: Text("No products Found.."),
            ),
    );
  }
}
