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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
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
                  category: '71',
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
                  category: '79',
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
                  category: '83',
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
                  category: '77',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "We are thankful to our sponsors..",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SponsorWidget(sponsoringText: "Karim Repair Glass"),
              SponsorWidget(sponsoringText: "Hedi Extreme GSM"),
              SponsorWidget(sponsoringText: "Haithem Hamdi"),
            ],
          ),
        ),
      ),
    );
  }
}

class SponsorWidget extends StatelessWidget {
  const SponsorWidget({
    Key key,
    this.sponsoringText,
  }) : super(key: key);

  final sponsoringText;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade800,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/sponsor.svg',
              width: size.width / 7,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  sponsoringText,
                  textAlign: TextAlign.center,
                  style: textTheme.subtitle1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
