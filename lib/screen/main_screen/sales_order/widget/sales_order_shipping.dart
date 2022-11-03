import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant.dart';
import '../../../../core/enum/connection_status.dart';
import '../../../../core/services/pdf_download_service.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/sales_order_provider.dart';

class DeliveryOrders extends StatefulWidget {
  final int id;
  final int orderId;
  final String orderCode;

  const DeliveryOrders(
      {Key? key,
      required this.id,
      required this.orderCode,
      required this.orderId})
      : super(key: key);

  @override
  State<DeliveryOrders> createState() => _SalesInvoiceState();
}

class _SalesInvoiceState extends State<DeliveryOrders> {
  @override
  void initState() {
    var data = Provider.of<SalesOrderProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        data.getDeliveryOrders(
            context: context,
            id: widget.id,
            orderId: widget.orderId,
            orderCode: widget.orderCode));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesOrderProvider>(builder: (context, salesData, _) {
      if (salesData.getOrderShippingStatus == ConnectionStatus.done) {
        var shippings = salesData.orderShippingModel.shippings;
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              AppLocalizations.of(context)!.deliveryOrders,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            shippings.length == 0
                                ? Text(
                              AppLocalizations.of(context)!
                                        .noInvoiceFound,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black54),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  AppLocalizations.of(context)!.shipping,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            Expanded(
                                                child: Text(
                                                  AppLocalizations.of(context)!.date,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            Expanded(
                                                child: Text(
                                                  AppLocalizations.of(context)!.status,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            Expanded(
                                                child: Text(
                                                  AppLocalizations.of(context)!.action,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      ...shippings
                                          .map(
                                            (shipping) => Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(shipping
                                                            .name
                                                        )),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                        child:


                                                        Text(
                                                      shipping.shipDate
                                                          ,
                                                    )),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                        child:
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(4)),
                                                            color: Theme.of(context).primaryColor,),
                                                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                                                          child:
                                                          Center(
                                                            child: Text(
                                                              shipping.state,
                                                              style: TextStyle(color: Colors.white),),
                                                          ),
                                                        )
                                                       ),
                                                    Expanded(
                                                      child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          InkWell(
                                                              onTap: () async {
                                                                var userProvider =
                                                                    Provider.of<
                                                                            AuthProvider>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                FileDownloadService
                                                                    service =
                                                                    FileDownloadService();
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (builder) {
                                                                      return AlertDialog(
                                                                          title:
                                                                              Row(
                                                                        children: [
                                                                          Text(
                                                                              "Downloading..."),
                                                                          Spacer(),
                                                                          CircularProgressIndicator(),
                                                                        ],
                                                                      ));
                                                                    });
                                                                await service
                                                                    .downloadFile(
                                                                        url:
                                                                            "$baseUrl/api/downloadInvoicePdf",
                                                                        headers: {
                                                                          "Content-Type":
                                                                              "application/json",
                                                                          "Authorization":
                                                                              "Bearer ${userProvider.userDetail.accessToken}",
                                                                          "user_id": userProvider
                                                                              .userDetail
                                                                              .userId
                                                                              .toString()
                                                                        },
                                                                        postBody: {
                                                                          "order_ship_id":
                                                                              shipping.orderShipId,
                                                                          "order_code":
                                                                              shipping.orderCode
                                                                        },
                                                                        name:
                                                                            "invoice_${shipping.orderId}.pdf");
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .download_outlined,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 22,
                                                                ),
                                                              )),
                                                          if (shipping
                                                                  .trackingUrl !=
                                                              "0")
                                                            InkWell(
                                                              onTap: () async {
                                                                try {
                                                                  await launchUrl(
                                                                      Uri.parse(
                                                                          shipping.trackingUrl));
                                                                } catch (e) {}
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .swap_vert_circle_outlined,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 22,
                                                                ),
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                if (shippings
                                                        .indexOf(shipping) <
                                                    shippings.length - 1)
                                                  Divider(),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
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
      } else {
        return Container(
            decoration: Constant().boxDecoration,
            child: IntrinsicHeight(
                child: Row(children: [
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
                      height: 8,
                    ),
                    Text(
                      AppLocalizations.of(context)!.deliveryOrders,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    Container(
                      height: 80,
                      child: Center(
                        child: Row(
                          children: [
                            Spacer(),
                            salesData.getOrderShippingStatus ==
                                    ConnectionStatus.error
                                ?  Text(AppLocalizations.of(context)!.wrongText)
                                : CircularProgressIndicator(),
                            Spacer(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ])));
      }
    });
  }
}
