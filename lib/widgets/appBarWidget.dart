import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/searchProvider.dart';
import 'package:ecommerce_app/screens/cartScreen.dart';
import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/Logo.png',
          width: size.width * .3,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // if (ModalRoute.of(context).settings.name != SearchScreen.routeName)
            //   Navigator.of(context).pushNamed(SearchScreen.routeName);
            showSearch(context: context, delegate: CitySearch());
          },
          icon: Icon(
            Icons.search,
          ),
        ),
        IconButton(
          onPressed: () {
            if (ModalRoute.of(context).settings.name != CartScreen.routeName)
              Navigator.of(context).pushNamed(CartScreen.routeName);
          },
          icon: Consumer<CartProvider>(
            child: Icon(
              Icons.shopping_bag_outlined,
            ),
            builder: (context, cartProvider, child) => Stack(
              alignment: Alignment.center,
              children: [
                child,
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    // color: Theme.of(context).accentColor,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.red,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      cartProvider.count.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CitySearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => Consumer<SearchProvider>(
        builder: (context, provider, child) => FutureBuilder<List<WooProduct>>(
          future: provider.searchProductByKeyword(query),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Something went wrong!',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  );
                } else {
                  return Container();
                }
            }
          },
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context, listen: false);

    return FutureBuilder<List<WooProduct>>(
      future: provider.searchProductByKeyword(query),
      builder: (context, snapshot) {
        if (query.isEmpty) return buildNoSuggestions();

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError || snapshot.data.isEmpty) {
              return buildNoSuggestions();
            } else {
              return Consumer<SearchProvider>(
                builder: (context, provider, child) => Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: buildSuggestionsSuccess(
                    snapshot.data,
                  ),
                ),
              );
            }
        }
      },
    );
  }

  Widget buildNoSuggestions() => Center(
        child: Text(
          ' ',
        ),
      );

  Widget buildSuggestionsSuccess(List<WooProduct> suggestions) =>
      ListView.builder(
        itemCount: suggestions.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      ProductScreen.routeName,
                      arguments: suggestion,
                    );
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      suggestion.images[0].src,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        suggestion.name,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        suggestion.price.toString() + ' TND',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
            ],
          );
        },
      );
}
