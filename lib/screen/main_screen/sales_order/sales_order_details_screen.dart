import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_bar.dart';
import '../../../../core/enum/connection_status.dart';
import '../../../../model/data_model/sales_order_detail_model.dart';
import '../../../../provider/sales_order_provider.dart';
import '../../../../screen/main_screen/sales_order/widget/sales_invoice.dart';
import '../../../../screen/main_screen/sales_order/widget/sales_order_pricing.dart';
import '../../../../screen/main_screen/sales_order/widget/sales_order_shipping.dart';
import '../../../../widget/custom_icon_button.dart';
import '../../../../widget/loading_idicator.dart';

import '../../../core/constant.dart';

class SalesOrderDetailScreen extends StatefulWidget {
  final int orderId;

  const SalesOrderDetailScreen({Key? key, required this.orderId})
      : super(key: key);

  @override
  State<SalesOrderDetailScreen> createState() => _SalesOrderDetailScreenState();
}

class _SalesOrderDetailScreenState extends State<SalesOrderDetailScreen> {
  @override
  void initState() {
    var data = Provider.of<SalesOrderProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        data.getSalesOrderDetail(context: context, orderId: widget.orderId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildDetailCard({required String title, required String data}) {
      return Expanded(
        child: Container(
          decoration: Constant().boxDecoration,
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(title,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        data,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    buildShippingAddress() {
      return Container(
        decoration: Constant().boxDecoration,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Delivery Orders",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          "ZAFCO AUTO SERVICES",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "LLC PCR[C0N21456]",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
      );
    }

    buildInvoiceAndShipping(
        {required String invoiceAddress, required String shippingAddress}) {
      return Container(
        decoration: Constant().boxDecoration,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Invoicing and Shipping Address",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Invoice Address",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(.7)),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(invoiceAddress),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Shipping Address",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(.7))),
                    SizedBox(
                      height: 2,
                    ),
                    Text(shippingAddress),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    buildSalesPerson(SalesPerson salesPerson) {
      return Container(
        decoration: Constant().boxDecoration,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Salesperson",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Constant().sendMail(emailId: salesPerson.email);
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: .8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              "Send Mail",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Material(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: salesPerson.image == null
                              ? Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Color(0xff7E7E7E),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Image.asset(
                                      "assets/icons/profile.png",
                                    ),
                                  ))
                              : ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  child: Container(
                                      height: 30,
                                      child: Constant()
                                          .getImage(imgSrc: salesPerson.image)),
                                ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          salesPerson.name,
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        CustomIconButton(
                            icon: Icons.email_outlined, onTap: () {}, size: 30),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          salesPerson.email,
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        CustomIconButton(
                          icon: Icons.phone,
                          onTap: () {},
                          size: 30,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          salesPerson.phone,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
      );
    }

    buildPaymentTerms(String paymentTerms) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: Constant().boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              "Payment terms",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              paymentTerms,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: getAppBar(title: Text("Sales Orders"), context: context),
      body: Consumer<SalesOrderProvider>(builder: (context, salesData, _) {
        if (salesData.getSalesOrderDetailStatus == ConnectionStatus.done) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sales Orders " +
                      salesData.salesOrderDetailModel.orderDetails.orderCode,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    buildDetailCard(
                        title: "Amount",
                        data:
                            "AED ${salesData.salesOrderDetailModel.orderDetails.amountTotal}"),
                    SizedBox(
                      width: 12,
                    ),
                    buildDetailCard(
                        title: "Order Date",
                        data:
                            "${salesData.salesOrderDetailModel.orderDetails.createdAt}"),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                buildInvoiceAndShipping(
                    invoiceAddress: salesData.salesOrderDetailModel.orderDetails
                        .invoiceAddress.address,
                    shippingAddress: salesData.salesOrderDetailModel
                        .orderDetails.shipAddress.address),
                SizedBox(
                  height: 12,
                ),
                if(salesData
                    .salesOrderDetailModel.orderDetails.user.salesPerson !=null)       buildSalesPerson(salesData
                    .salesOrderDetailModel.orderDetails.user.salesPerson! ),
                SizedBox(
                  height: 12,
                ),
                SalesInvoice(
                  orderCode:
                      salesData.salesOrderDetailModel.orderDetails.orderCode,
                  orderId: salesData.salesOrderDetailModel.orderDetails.id,
                ),

                SizedBox(
                  height: 12,
                ),
                DeliveryOrders(
                  id: salesData.salesOrderDetailModel.orderDetails.id,
                  orderId: salesData.salesOrderDetailModel.orderDetails.orderId,
                  orderCode:
                      salesData.salesOrderDetailModel.orderDetails.orderCode,
                ),

                SizedBox(
                  height: 18,
                ),
                SalesOrderPricing(
                    orderItems:
                        salesData.salesOrderDetailModel.orderDetails.orderItems,
                    amountWithoutTax: salesData
                        .salesOrderDetailModel.orderDetails.amountWithoutTax,
                    taxAmount:
                        salesData.salesOrderDetailModel.orderDetails.taxAmount,
                    totalAmount: salesData
                        .salesOrderDetailModel.orderDetails.amountTotal,
                    orderId: salesData
                        .salesOrderDetailModel.orderDetails.orderId
                        .toString(),
                    orderCode:
                        salesData.salesOrderDetailModel.orderDetails.orderCode),
                SizedBox(
                  height: 12,
                ),
                buildPaymentTerms(salesData.salesOrderDetailModel.orderDetails.paymentTerms),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          );
        } else if (salesData.getSalesOrderDetailStatus ==
            ConnectionStatus.error) {
          return Center(child: Text("Something went wrong"));
        } else {
          return Center(
            child: LoadingIndicator(),
          );
        }
      }),
    );
  }
}
