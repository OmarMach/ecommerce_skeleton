import 'package:ecommerce_app/config.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/carouselWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/productsByCategoryGrid.dart';
import 'package:ecommerce_app/widgets/productsGridList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CarouselWidget(),
                  verticalSeparator,
                  HomeTitleWidget(title: "New Arrivals"),
                  ProductsGridList(
                    limit: 5,
                  ),
                  HomeTitleWidget(title: "Screen Refurbish Tools"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductsByCategoryGridList(
                      categoryId: 71,
                      limit: 5,
                    ),
                  ),
                  HomeTitleWidget(title: "Soldering accessories"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductsByCategoryGridList(
                      limit: 5,
                      categoryId: 79,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTitleWidget extends StatelessWidget {
  final String title;

  const HomeTitleWidget({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          redBox,
          redBox,
          redBox,
          redBox,
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          redBox,
          redBox,
          redBox,
          redBox,
        ],
      ),
    );
  }
}
