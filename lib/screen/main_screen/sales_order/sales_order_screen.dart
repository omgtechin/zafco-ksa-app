import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/sales_order_provider.dart';
import '../../../../widget/custom_icon_button.dart';
import '../../../../widget/loading_idicator.dart';

import '../../../core/app_bar.dart';
import '../../../core/enum/connection_status.dart';
import '../../../core/enum/user_type.dart';
import '../../../provider/cart_provider.dart';
import '../../../widget/customer_selector.dart';
import '../../../widget/order_card.dart';

class SalesOrderScreen extends StatefulWidget {
  const SalesOrderScreen({Key? key}) : super(key: key);

  @override
  State<SalesOrderScreen> createState() => _SalesOrderScreenState();
}

class _SalesOrderScreenState extends State<SalesOrderScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    var salesOrder = Provider.of<SalesOrderProvider>(context, listen: false);
    var auth = Provider.of<AuthProvider>(context, listen: false);
    var cart = Provider.of<CartProvider>(context, listen: false);

    if (auth.userDetail.userType == UserType.employee) {
      auth.updateCustomer(updatedCustomerId: -1);
    }
    SchedulerBinding.instance
        .addPostFrameCallback((_) {
          cart.getCartCount(context: context);
          salesOrder.getSalesOrders(context: context);

        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<AuthProvider>(context, listen: false);
    var salesData = Provider.of<SalesOrderProvider>(context, listen: false);

    return Scaffold(
      appBar: getAppBar(
          title: Text(
            "Sales Order",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          context: context),
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          if (userData.userDetail.userType == UserType.employee)
            CustomerSelector(
                showAll: true,
                onCustomerChange: () {

                  salesData.getSalesOrders(context: context);
                }),
          if (userData.userDetail.userType == UserType.employee)
            SizedBox(
              height: 12,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: .8)),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search Here',
                                  ),
                                  onSubmitted: (String? val) {
                                    if (val != null) {

                                      salesData.applyFilter(
                                          filter:{ "search": val} , context: context);
                                    }
                                  },
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    if (_controller.text != "") {

                                      salesData.applyFilter(
                                          filter:{ "search": _controller.text} , context: context);
                                    }
                                  },
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                      ))),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                  onTap: () {
                                    if (_controller.text != "") {

                                      salesData.clearSearchFilter(context: context);
                                      _controller.clear();
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      Icons.close,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )),
                            ],
                          ),
                        ))
                      ])),
                ),
                SizedBox(
                  width: 12,
                ),
                CustomIconButton(
                  icon: Icons.calendar_today_outlined,
                  onTap: () async {
                    var pickedData = await showDatePicker(
                      confirmText: "APPLY",
                      context: context,
                      firstDate: DateTime(2019),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                    );
                    if (pickedData != null) {
                      String selected =
                          formatDate(pickedData, [yyyy, '-', mm, '-', dd]);
                      salesData.applyFilter(
                          filter:{ "date": selected} , context: context);
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Expanded(
            child: Consumer<SalesOrderProvider>(builder: (context, data, _) {
              if (data.getSalesOrdersStatus == ConnectionStatus.done) {
                return ListView.builder(
                    itemCount: data.salesOrderModel.orders.orderData.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          OrderCard(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  Screen.salesOrderDetailScreen.toString(),
                                  arguments: data.salesOrderModel.orders
                                      .orderData[index].id);
                            },
                            order: data.salesOrderModel.orders.orderData[index],
                          ),
                          if (index ==
                                  data.salesOrderModel.orders.orderData.length -
                                      1 &&
                              data.salesOrderModel.orders.lastPage !=
                                  data.salesOrderModel.orders.currentPage)
                            Column(
                              children: [
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  "Showing ${data.salesOrderModel.orders.from} to ${data.salesOrderModel.orders.to} of ${data.salesOrderModel.orders.total} Orders",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    Container(
                                      child: NumberPaginator(
                                        config: NumberPaginatorUIConfig(
                                            buttonSelectedBackgroundColor:
                                                Theme.of(context).primaryColor,
                                            buttonShape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            contentPadding: EdgeInsets.all(0),
                                            buttonUnselectedForegroundColor:
                                                Theme.of(context).primaryColor,
                                            mode: ContentDisplayMode.dropdown),
                                        numberPages: data
                                            .salesOrderModel.orders.lastPage,
                                        initialPage: data.salesOrderModel.orders
                                                .currentPage -
                                            1,
                                        onPageChange: (int index) {
                                          data.getSalesOrders(
                                              context: context,
                                              pageIndex: index + 1);
                                        },
                                      ),
                                      width: 160,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                              ],
                            )
                        ],
                      );
                    });
              } else if (data.getSalesOrdersStatus == ConnectionStatus.active) {
                return Center(child: LoadingIndicator());
              } else {
                return Center(
                  child: Text("No Product Found"),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
