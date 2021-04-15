import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

class ProductsByCategoryGridList extends StatelessWidget {
  final int limit;
  const ProductsByCategoryGridList({
    Key key,
    @required this.categoryId,
    @required this.limit,
  }) : super(key: key);

  final int categoryId;

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
      future: Provider.of<ProductProvider>(context, listen: false)
          .getProductsByCategory(categoryId),
      builder: (context, AsyncSnapshot<List<WooProduct>> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length > limit
                      ? limit
                      : snapshot.data.length,
                  gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
                  itemBuilder: (context, index) {
                    return ProductWidget(product: snapshot.data[index]);
                  },
                ),
    );
  }
}
