import 'package:ecommerce_app/config.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/carouselWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/productsByCategoryGrid.dart';
import 'package:ecommerce_app/widgets/productsGridList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

  HomeTitleWidget({
    Key key,
    @required this.title,
  }) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent / 2);
    });
    final size = MediaQuery.of(context).size;
    final redBox = Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 10,
        height: 20,
        color: Colors.redAccent,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: size.width * 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              redBox,
              redBox,
              redBox,
              redBox,
              InkWell(
                onTap: () {
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent / 2);
                },
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
              redBox,
              redBox,
              redBox,
              redBox,
            ],
          ),
        ),
      ),
    );
  }
}
