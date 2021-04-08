import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/widgets/productsByCategoryGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

import '../utils.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final product = ModalRoute.of(context).settings.arguments as WooProduct;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                product.images[0].src,
                fit: BoxFit.contain,
                height: size.height / 3,
                width: size.width,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  product.name,
                  style: textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Price : ${product.price} TND ",
                textAlign: TextAlign.center,
                style: textTheme.subtitle1.copyWith(
                  color: Colors.green,
                ),
              ),
              if (product.stockStatus != 'instock')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      horizontalSeparator,
                      Text(
                        'Out of stock',
                        style: textTheme.subtitle1.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              if (product.stockStatus == 'instock')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      Text(
                        'In stock',
                        textAlign: TextAlign.center,
                        style: textTheme.subtitle1.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              Divider(),
              if (product.categories != null)
                ...product.categories
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            e.name,
                            textAlign: TextAlign.center,
                            style: textTheme.subtitle1.copyWith(
                              color: Colors.cyan,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              Divider(),
              ElevatedButton.icon(
                icon: Icon(
                  product.stockStatus != 'instock'
                      ? Icons.shopping_bag_outlined
                      : Icons.shopping_bag,
                ),
                onPressed: product.stockStatus != 'instock'
                    ? null
                    : () {
                        cartProvider.addCartItem(product);
                      },
                label: Text(
                  product.stockStatus != 'instock'
                      ? "Out of stock"
                      : "Add To cart",
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(
                  Icons.favorite,
                ),
                onPressed: () {
                  print(product.name + " Added to favorites.");
                },
                label: Text(
                  "Add To wish list",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline_outlined),
                    horizontalSeparator,
                    Text(
                      "All products will be delivered by \"Aramex\".",
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline_outlined),
                    horizontalSeparator,
                    Text(
                      "We also provide the possibility of local pickup.",
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              if (removeAllHtmlTags(product.description)
                  .trim()
                  .replaceAll('\n\n', '\n')
                  .isNotEmpty) ...[
                Divider(),
                Text(
                  "Description",
                  textAlign: TextAlign.start,
                  style: textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    removeAllHtmlTags(product.description)
                            .trim()
                            .replaceAll('\n\n', '\n') +
                        ".",
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
              Divider(),
              Text(
                "Related products",
                textAlign: TextAlign.start,
                style: textTheme.headline5,
              ),
              verticalSeparator,
              ProductsByCategoryGridList(
                categoryId: product.categories[0].id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
