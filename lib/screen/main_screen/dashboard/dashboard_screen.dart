import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../../core/enum/user_type.dart';
import '../../../../provider/dashboard_provider.dart';
import '../../../../screen/main_screen/dashboard/widget/best_sellers.dart';
import '../../../../screen/main_screen/dashboard/widget/dashboard_carousel.dart';
import '../../../../screen/main_screen/dashboard/widget/dashboard_details.dart';
import '../../../../screen/main_screen/dashboard/widget/recent_orders.dart';
import '../../../../widget/loading_idicator.dart';

import '../../../core/app_bar.dart';
import '../../../core/enum/connection_status.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    var data = Provider.of<DashboardProvider>(context, listen: false);
    var cart = Provider.of<CartProvider>(context, listen: false);

    SchedulerBinding.instance
        .addPostFrameCallback((_) {
          data.loadDashboard(context: context);
          cart.getCartCount(context: context);
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: getAppBar(
          title: Image.asset(
            "assets/app_icon.png",
            height: 30,
          ),
          context: context),
      body: Consumer<DashboardProvider>(builder: (context, data, _){


        if (data.connectionStatus == ConnectionStatus.done) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                if (data.dashboardData.dashboard.banners.isNotEmpty)
                  Column(
                    children: [

                      DashboardCarousel(data: data.dashboardData),
                      if (userData.userDetail.userType == UserType.customer)
                        SizedBox(
                          height: 24,
                        ),
                      if (userData.userDetail.userType == UserType.customer)
                        DashboardDetails(dashboard: data.dashboardData),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                RecentOrders(data: data.dashboardData),
                SizedBox(
                  height: 24,
                ),
                BestSellers(data: data.dashboardData),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
          );
        } else if(data.connectionStatus == ConnectionStatus.error){
          return Center(
            child: Text(AppLocalizations.of(context)!.wrongText),
          );
        }else {

          return Center(
            child: LoadingIndicator(),
          );
        }


        }
      ),
    );
  }
}
