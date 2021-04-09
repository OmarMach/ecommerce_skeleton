import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/favoritesProvider.dart';
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
  int currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final product = ModalRoute.of(context).settings.arguments as WooProduct;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        product.images[currentImageIndex].src,
                        fit: BoxFit.cover,
                        height: size.height / 2,
                        width: size.width,
                      ),
                      // Only show the controls if the products have more than 1 image.
                      if (product.images.length > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (currentImageIndex > 0)
                              Material(
                                color: Colors.black.withAlpha(150),
                                child: InkWell(
                                  child: SizedBox(
                                    height: size.height / 2,
                                    width: 35,
                                    child: Icon(
                                      Icons.keyboard_arrow_left_outlined,
                                    ),
                                  ),
                                  onTap: () {
                                    if (currentImageIndex > 0)
                                      setState(() {
                                        currentImageIndex--;
                                      });
                                  },
                                ),
                              ),
                            // This box Prevents from the buttons changing their locations
                            Expanded(child: SizedBox()),
                            if (currentImageIndex < product.images.length - 1)
                              Material(
                                color: Colors.black.withAlpha(150),
                                child: InkWell(
                                  child: SizedBox(
                                    height: size.height / 2,
                                    width: 35,
                                    child: Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                    ),
                                  ),
                                  onTap: () {
                                    if (currentImageIndex <
                                        product.images.length)
                                      setState(() {
                                        currentImageIndex++;
                                      });
                                  },
                                ),
                              ),
                          ],
                        )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                        // this box prevents from hiding the grid elements.
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          splashColor: Colors.teal,
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            width: 45,
                            height: 45,
                            child: Icon(
                              Icons.arrow_back_rounded,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Material(
                        color: product.stockStatus != 'instock'
                            ? Colors.grey.shade600
                            : Colors.blueGrey.shade600,
                        child: InkWell(
                          splashColor: Colors.teal,
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Rendering shopping cart if in stock
                                if (product.stockStatus == 'instock') ...[
                                  Icon(
                                    Icons.shopping_bag_rounded,
                                  ),
                                  Text("Add to cart"),
                                ],
                                // Rendering message if out of stock
                                if (product.stockStatus != 'instock') ...[
                                  Text("Out of stock"),
                                ]
                              ],
                            ),
                          ),
                          onTap: product.stockStatus != 'instock'
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Item Added to the cart.."),
                                    ),
                                  );
                                  Provider.of<CartProvider>(
                                    context,
                                    listen: false,
                                  ).addCartItem(product);
                                },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Material(
                        color: Colors.red.shade400,
                        child: InkWell(
                          splashColor: Colors.red,
                          child: SizedBox(
                            height: 60,
                            child: Icon(
                              Icons.favorite,
                            ),
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Item Added to the favorites.."),
                              ),
                            );
                            Provider.of<FavoritesProvider>(context,
                                    listen: false)
                                .addToFavorites(product);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
