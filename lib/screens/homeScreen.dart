import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/screens/cartScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/badge.dart';
import 'package:ecommerce_app/widgets/carouselWidget.dart';
import 'package:ecommerce_app/widgets/productsByCategoryGrid.dart';
import 'package:ecommerce_app/widgets/productsGridList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Goods"),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              child: child,
              value: cart.count.toString(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.shopping_basket_outlined,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row(
              //   children: [
              //     Flexible(
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //           hintText: "Search products..",
              //           border: OutlineInputBorder(),
              //         ),
              //       ),
              //     ),
              //     IconButton(
              //         icon: Icon(Icons.search),
              //         onPressed: () {
              //           Navigator.of(context).pushNamed(SearchScreen.routeName);
              //         })
              //   ],
              // ),
              // verticalSeparator,
              // CarouselWidget(),
              // verticalSeparator,
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                },
                child: Text("Search"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "New Arrivals",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              ProductsGridList(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Screen Refurbish Tools",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductsByCategoryGridList(
                  categoryId: 71,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Soldering accessories",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductsByCategoryGridList(
                  categoryId: 79,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Tool Organizer",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductsByCategoryGridList(
                  categoryId: 83,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hand Tools",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductsByCategoryGridList(
                  categoryId: 77,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
