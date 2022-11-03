import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../provider/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../core/enum/user_type.dart';
import '../model/data_model/sales_order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderData order;
  final Function onTap;

  const OrderCard({Key? key, required this.order, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  String  getTitle(String title){
      String lowerTitle = title.trim().toLowerCase();
      if(lowerTitle == "order created"){
      return  AppLocalizations.of(context)!.orderCreated;
      }else if(lowerTitle == "pending for credit check"){
        return  AppLocalizations.of(context)!.pendingForCreditCheck;
      }else if(lowerTitle == "completed"){
        return  AppLocalizations.of(context)!.completed;
      }else if(lowerTitle == "cancelled"){
        return  AppLocalizations.of(context)!.cancelled;
      }

      else{
        return title;
    }
    }
    Constant _constsnt = Constant();
    var userData = Provider.of<AuthProvider>(context);
    buildDetails({required String title, required String data}) {
      return Row(

        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          
          Expanded(
            flex: 2,
            child: Text(
              data,
              style: TextStyle(fontSize: 16),
            ),
          ), 
        ],
      );
    }

    return Container(
      decoration: Constant().boxDecoration,
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
      padding: EdgeInsets.all(8),
      child: Column(

        children: [
          SizedBox(
            height: 8,
          ),
          buildDetails(title: AppLocalizations.of(context)!.salesOrder, data: order.orderCode),
          if (userData.userDetail.userType == UserType.employee)
            SizedBox(
              height: 12,
            ),
          if (userData.userDetail.userType == UserType.employee)
            buildDetails(
                title: AppLocalizations.of(context)!.customer,
                data: Constant()
                    .getUserName(userId: order.userId, context: context)),
          SizedBox(
            height: 12,
          ),
          buildDetails(title: AppLocalizations.of(context)!.orderDate, data: order.createdAt),
          SizedBox(
            height: 12,
          ),
          buildDetails(title:AppLocalizations.of(context)!.price, data: "AED ${order.amountTotal}"),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [

              Expanded(child: Text(AppLocalizations.of(context)!.status, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)),


              Expanded(
                flex: 2,

                child:  Text(
                  getTitle(order.status),
                  style: TextStyle(
                    color: _constsnt.getStatusColor(status: order.status),fontSize: 15,fontWeight: FontWeight.w700
                  ),
                )
              ),



            ],
          ),
          SizedBox(
            height: 12,
          ),
          OutlinedButton.icon(
            onPressed: () {
              onTap();
            },
            icon: Text(AppLocalizations.of(context)!.view),
            label: Icon(
              Icons.image_search,
            ),
            style: OutlinedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                minimumSize: Size(double.infinity, 40)),
          ),
        ],
      ),
    );

    Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 3,
                  offset: Offset(2, 2), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetails(title: "Sales Order", data: order.orderCode),
                    if (userData.userDetail.userType == UserType.employee)
                      Spacer(),
                    if (userData.userDetail.userType == UserType.employee)
                      buildDetails(
                          title: "Customer",
                          data: Constant().getUserName(
                              userId: order.userId, context: context)),
                    Spacer(),
                    buildDetails(title: "Order Date", data: order.createdAt),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                              color: _constsnt.getStatusColor(
                                  status: order.status),
                              width: .8)),
                      height: 35,
                      child: Center(
                          child: Text(
                        order.status,
                        style: TextStyle(
                          color: _constsnt.getStatusColor(status: order.status),
                        ),
                      )),
                    ),
                    Spacer(),
                    Text(
                      "AED ${order.amountTotal}",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    onTap();
                  },
                  icon: Text("View"),
                  label: Icon(
                    Icons.image_search,
                  ),
                  style: OutlinedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      minimumSize: Size(double.infinity, 42)),
                ),
              ],
            ),
          )),
    );
  }
}
