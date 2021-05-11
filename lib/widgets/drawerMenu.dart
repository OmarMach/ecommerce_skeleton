import 'package:ecommerce_app/models/CategoryItem.dart';
import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/screens/categoryProductsScreen.dart';
import 'package:ecommerce_app/screens/favoritesScreen.dart';
import 'package:ecommerce_app/screens/homeScreen.dart';
import 'package:ecommerce_app/screens/orderScreen.dart';
import 'package:ecommerce_app/screens/profileScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 20.0),
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: size.width / 10,
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Browse",
                  style: textTheme.caption,
                ),
              ),
              DrawerMenuItem(
                icon: Icons.home,
                label: 'Home',
                onTap: () {
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                },
              ),
              DrawerMenuItem(
                icon: Icons.favorite,
                label: 'My Wishlist',
                onTap: () {
                  Navigator.of(context).pushNamed(FavoritesScreen.routeName);
                },
              ),
              DrawerMenuItem(
                icon: Icons.search,
                label: 'Search products',
                onTap: () {
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                },
              ),
              DrawerMenuItem(
                icon: Icons.person,
                label: 'My Account',
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileScreen.routeName);
                },
              ),
              DrawerMenuItem(
                icon: Icons.payment,
                label: 'Checkout',
                onTap: () {
                  Navigator.of(context).pushNamed(OrderScreen.routeName);
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Categories",
                  style: textTheme.caption,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    CategoryProductsScreen.routeName,
                    arguments: {'New Arrivals': 0},
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.fire),
                      horizontalSeparator,
                      Text("New Arrivals"),
                    ],
                  ),
                ),
              ),
              DrawerCategoriesMenu(),
              Divider(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Call us on",
                      style: textTheme.caption,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: InkWell(
                        onTap: () {
                          launch("tel://31137337");
                        },
                        child: Chip(
                          avatar: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Icon(
                              Icons.call,
                              size: 20,
                            ),
                          ),
                          backgroundColor: Colors.green,
                          label: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "31 137 337",
                              style: textTheme.subtitle2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: InkWell(
                        onTap: () {
                          launch("tel://53768766");
                        },
                        child: Chip(
                          avatar: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Icon(
                              Icons.call,
                              size: 20,
                            ),
                          ),
                          backgroundColor: Colors.green,
                          label: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "53 768 766",
                              style: textTheme.subtitle2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerCategoriesMenu extends StatelessWidget {
  const DrawerCategoriesMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the list of transformed categories
    final List<CategoryItem> categories =
        Provider.of<CategoriesProvider>(context, listen: false)
            .transformedCategories;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories.elementAt(index);
        return DrawerCategoryItem(
          category: category,
          icon: buildCategoryIcon(category.name),
        );
      },
    );
  }
}

IconData buildCategoryIcon(String category) {
  switch (category) {
    case 'Accessories':
      return FontAwesomeIcons.toolbox;
      break;
    case 'Equipments Tools':
      return FontAwesomeIcons.chargingStation;
      break;
    case 'Hand tools':
      return FontAwesomeIcons.wrench;
      break;
    case 'IC Chips':
      return FontAwesomeIcons.microchip;
      break;
    case 'Programming Tools':
      return FontAwesomeIcons.laptopCode;
      break;
    case 'Soldering • Desoldering':
      return FontAwesomeIcons.screwdriver;
      break;
    default:
      return FontAwesomeIcons.wrench;
      break;
  }
}

class DrawerCategoryItem extends StatefulWidget {
  final CategoryItem category;
  final IconData icon;
  const DrawerCategoryItem({
    Key key,
    @required this.category,
    @required this.icon,
  }) : super(key: key);

  @override
  _DrawerCategoryItemState createState() => _DrawerCategoryItemState();
}

class _DrawerCategoryItemState extends State<DrawerCategoryItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                CategoryProductsScreen.routeName,
                arguments: {widget.category.name: widget.category.category.id},
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FaIcon(
                      widget.icon,
                      color: Colors.white,
                    ),
                    horizontalSeparator,
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          CategoryProductsScreen.routeName,
                          arguments: {
                            widget.category.name: widget.category.category.id
                          },
                        );
                      },
                      child: Text(
                        widget.category.name,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded)
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.category.subCategories.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final subCategory =
                    widget.category.subCategories.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              CategoryProductsScreen.routeName,
                              arguments: {subCategory.name: subCategory.id},
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(subCategory.name),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;
  const DrawerMenuItem({
    Key key,
    @required this.label,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
