import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/providers/favoritesProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/providers/searchProvider.dart';
import 'package:ecommerce_app/routes.dart';
import 'package:ecommerce_app/screens/errorScreen.dart';
import 'package:ecommerce_app/screens/homeScreen.dart';
import 'package:ecommerce_app/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goods.tn',
        theme: ThemeData(
          brightness: Brightness.dark,
          buttonTheme: Theme.of(context)
              .buttonTheme
              .copyWith(buttonColor: Colors.grey.shade700),
          fontFamily: 'ProductSans',
          primaryColor: Colors.grey.shade800,
          accentColor: Colors.redAccent,
        ),
        routes: routes,

        // Getting all the products and categories from the database.
        // displaying slpash screen while the data is loading.
        home: LoadingWidget(),
      ),
    );
  }
}

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, CategoriesProvider>(
      builder: (context, productProvider, categoriesProvider, child) {
        Future<dynamic> load(BuildContext context) async {
          print("Loading prods");
          await productProvider.getProductsFromDb(context);

          print("Loading cats");
          await categoriesProvider.getAllCategories(context);
          return Future;
        }

        // Checking if there are already products and categories in the app State

        if (productProvider.items.length == 0 &&
            categoriesProvider.categories['categories'].length == 0)
          return FutureBuilder(
            future: load(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return SplashScreen();
              if (snapshot.hasError)
                return ErrorScreen(errorMessage: snapshot.error.toString());
              else
                return HomeScreen();
            },
          );
        else
          // going directly to homescreen while there are items in the state
          return HomeScreen();
      },
    );
  }
}
