import 'package:flutter/material.dart';
import '../../../../core/constant.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../widget/order_card.dart';

import '../../../../core/routes.dart';
import '../../../../model/data_model/dashboard_model.dart';

class RecentOrders extends StatelessWidget {
  final DashboardModel data;

  const RecentOrders({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildDetail({required String title, required String value}) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 14),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      );
    }

    buildRecentOrderCard(RecentOrder order) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: Constant().boxDecoration,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  order.orderCode,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
            Row(
              children: [
                buildDetail(title: "Sales Order", value: order.orderCode),
                SizedBox(
                  width: 8,
                ),
                buildDetail(title: "Order Date", value: order.createdAt),
                buildDetail(
                    title: "Customer Id", value: order.customerId.toString()),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).priceColor),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Text(order.status,style: TextStyle(
                    color: Theme.of(context).priceColor,
                  ),),
                ),
                Spacer(),
                Text("AED " + order.amountTotal,style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),),
                SizedBox(width: 12,)
              ],
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Text(
                "Recent Orders",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor),
              ),
              Spacer(),
              Container(
                  width: 100,
                  height: 35,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Screen.mainScreen.toString(), arguments: {"pageId" :1});
                    },
                    child: Text("View All"),
                  )),
            ],
          ),
        ),
        ...data.dashboard.recentOrders
            .map((order) => Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    OrderCard(order: order, onTap:(){
                    Navigator.of(context).pushNamed(
                        Screen.salesOrderDetailScreen.toString(),
                        arguments: order.id);}
                    )

                  ],
                ))
            .toList(),
      ],
    );
  }
}
