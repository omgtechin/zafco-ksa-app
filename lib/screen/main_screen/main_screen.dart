import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../screen/main_screen/sales_order/sales_order_screen.dart';
import '../../../../screen/main_screen/shop/shop_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dashboard/dashboard_screen.dart';
import 'invoice/invoice_screen.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  final String? filterType;
  final List<String>? filterList;
  const MainScreen({Key? key, required this.index, required this.filterList, required this.filterType}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late int currentIndex;
  @override
  void initState() {
    currentIndex = widget.index??2;
  var provider = Provider.of<CartProvider>(context,listen: false);
    SchedulerBinding.instance
        .addPostFrameCallback((_) => provider.getCartCount(context: context));
    super.initState();
  }



  String getIcon(String iconName) => "assets/icons/$iconName.png";

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(

          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          unselectedItemColor:
              Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.85),
          unselectedLabelStyle:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          selectedItemColor: Theme.of(context).primaryColor,
          iconSize: 22,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(getIcon("invoice"),height: 18,),
              activeIcon: Image.asset(
                getIcon("invoice"),
                height: 18,
                color: primaryColor,
              ),
              label: AppLocalizations.of(context)!.invoices,
            ),
            BottomNavigationBarItem(
                icon: Image.asset(getIcon("sales_order"),height: 26,),
                activeIcon: Image.asset(
                  getIcon("sales_order"),
                  height: 26,
                  color: primaryColor,
                ),
                label: AppLocalizations.of(context)!.salesOrder),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard_outlined,
                ),
                activeIcon: Icon(
                  Icons.dashboard_outlined,
                ),
                label: AppLocalizations.of(context)!.dashboard),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                activeIcon: Icon(Icons.shopping_bag_outlined),
                label: AppLocalizations.of(context)!.shop),
          ],
          type: BottomNavigationBarType.fixed,
          onTap: (index) async {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        body: getIndex());
  }

  getIndex() {
    if (currentIndex == 0) {
      return InvoiceScreen();
    } else if (currentIndex == 1) {
      return SalesOrderScreen();
    } else if (currentIndex == 2) {
      return DashboardScreen();
    } else if (currentIndex == 3) {
      return ShopScreen(filters: widget.filterList,filterType: widget.filterType,);
    } else {
      return Container();
    }
  }
}
