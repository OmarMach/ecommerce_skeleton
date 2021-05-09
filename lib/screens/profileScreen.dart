import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/notConnectedWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, provider, _) {
            // if (provider.isConnected)
            //   return Container();
            // else
            //   return NotconnectedWidget();
            return DashboardWidget();
          },
        ),
      ),
    );
  }
}

class DashboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "My Account",
                textAlign: TextAlign.center,
                style: textTheme.headline5,
              ),
            ),

            // DashboardMenuItemWidget(
            //   title: 'Dashboard',
            //   icon: Icons.dashboard,
            //   onTap: () {},
            // ),
            DashboardMenuItemWidget(
              title: 'Orders',
              icon: Icons.shopping_bag_rounded,
              onTap: () {},
            ),
            DashboardMenuItemWidget(
              title: 'Addresses',
              icon: Icons.home,
              onTap: () {},
            ),
            DashboardMenuItemWidget(
              title: 'Account details',
              icon: Icons.person_pin_rounded,
              onTap: () {},
            ),
            DashboardMenuItemWidget(
              title: 'Logout',
              icon: Icons.logout,
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Hello User, From your account dashboard you can view your recent orders, manage your shipping and billing addresses, and edit your password and account details.",
                textAlign: TextAlign.justify,
                style: textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardMenuItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const DashboardMenuItemWidget({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
