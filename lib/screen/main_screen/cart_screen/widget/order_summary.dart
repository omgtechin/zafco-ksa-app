import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant.dart';

import '../../../../model/data_model/cart_model.dart';

class OrderSummaryCard extends StatelessWidget {
  final OrderSummary orderSummary;
  const OrderSummaryCard({
    Key? key,required this.orderSummary
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildLine() {
      return Container(
        height: .5,
        color: Theme.of(context).primaryColor,
      );
    }

    buildDashedLine() {
      return DottedLine(
        dashColor: Theme.of(context).primaryColor,
      );
    }

    buildDetails({
      required String title,
      required String data,
    }) {
      return Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          Spacer(),
          Text(
            data,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          )
        ],
      );
    }

    buildFadedDetails({
      required String title,
      required String data,
    }) {
      return Row(
        children: [
          Expanded(
            flex: 10,
            child: Text(

              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Spacer(),
          Text(
            data,
            style: TextStyle(
              fontSize: 14,
            ),
          )
        ],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: Constant().boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            "Order Summary",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 12,
          ),
          buildLine(),
          SizedBox(
            height: 12,
          ),
          buildDetails(title: "Total Qty", data: orderSummary.orderQuantity.totalQuantity.toString()),
          SizedBox(
            height: 8,
          ),
          buildLine(),


          ...orderSummary.productDetail.map((detail) {
            return Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                buildFadedDetails(
                    title: detail.productName, data:detail.quantity.toString()),
                SizedBox(
                  height: 8,
                ),
              if(orderSummary.productDetail.indexOf(detail) != orderSummary.productDetail.length -1)  buildDashedLine(),
              ],
            );
          }).toList(),
          

          buildLine(),
          SizedBox(
            height: 8,
          ),
          buildDetails(title: "Subtotal", data: "AED ${orderSummary.orderQuantity.subTotal.toStringAsFixed(2)}"),
          SizedBox(
            height: 8,
          ),
          buildDashedLine(),
          SizedBox(
            height: 6,
          ),
          buildDetails(title: "VAT-Tax 5%", data: "AED ${orderSummary.orderQuantity.tax.toStringAsFixed(2)}"),
          SizedBox(
            height: 8,
          ),
          buildLine(),
          SizedBox(
            height: 8,
          ),
          buildDetails(title: "Total", data: "AED ${orderSummary.orderQuantity.grandTotal.toStringAsFixed(2)}"),
          SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}
