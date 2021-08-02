import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/productsByCategoryGridListPaginated.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class CategoryProductsScreen extends StatefulWidget {
  static const routeName = '/categoryProds';
  @override
  CategoryProductsScreenState createState() => CategoryProductsScreenState();
}

class CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeat,
              image: AssetImage('assets/images/background.jpg'),
            ),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    category.keys.first ?? '',
                    textAlign: TextAlign.center,
                    style: textTheme.headline5,
                  ),
                ),
                verticalSeparator,
                ProductsByCategoryGridListPaginated(
                  // sending this scroll controller to reset scrolling position when clicked on next button.
                  scrollController: _scrollController,
                  categoryId: category.values.first,
                  limit: category.values.first == 0 ? 100 : 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
