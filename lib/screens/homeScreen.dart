import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/carouselWidget.dart';
import 'package:ecommerce_app/widgets/comingsoonCarouselWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/productsByCategoryGrid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeat,
              image: AssetImage('assets/images/background.jpg'),
            ),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CarouselWidget(),
                      verticalSeparator,
                      HomeTitleWidget(title: "New Arrivals"),
                      ProductsByCategoryGridList(
                        categoryId: 0,
                        limit: 6,
                      ),
                      HomeTitleWidget(title: "Screen Refurbish Tools"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductsByCategoryGridList(
                          categoryId: 71,
                          limit: 6,
                        ),
                      ),
                      HomeTitleWidget(title: "Soldering accessories"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductsByCategoryGridList(
                          limit: 6,
                          categoryId: 79,
                        ),
                      ),
                      verticalSeparator,
                      HomeTitleWidget(title: "Best Selling"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ComingSoonCarouselWidget(),
                      ),
                      ContactWidget(),

                      // verticalSeparator,
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: Image.asset(
                      //     'assets/images/proff.jpg',
                      //     width: size.width,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Colors.redAccent,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "We're a repair professionals",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      await launch('https://www.facebook.com/GOODS.TN/');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          FaIcon(FontAwesomeIcons.facebook),
                          Text(
                            "GOODS•Tn",
                            style: textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      await launch('https://www.facebook.com/ajbouni.toufa');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          FaIcon(FontAwesomeIcons.userAlt),
                          Text(
                            "Ajbouni Taoufik",
                            style: textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      await launch(
                          "https://www.facebook.com/groups/tunisiaskills");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          FaIcon(FontAwesomeIcons.users),
                          Text(
                            "GSM Skills",
                            style: textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Divider(
              color: Colors.redAccent,
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.redAccent,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
