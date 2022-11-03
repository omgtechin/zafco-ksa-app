import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../../model/data_model/order_invoice_model.dart';
import '../../../../provider/sales_order_provider.dart';

import '../../../../core/constant.dart';
import '../../../../core/enum/connection_status.dart';
import '../../../../core/services/pdf_download_service.dart';
import '../../../../provider/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalesInvoice extends StatefulWidget {
  final int orderId;
  final String orderCode;

  const SalesInvoice({Key? key, required this.orderCode, required this.orderId})
      : super(key: key);

  @override
  State<SalesInvoice> createState() => _SalesInvoiceState();
}

class _SalesInvoiceState extends State<SalesInvoice> {
  @override
  void initState() {
    var data = Provider.of<SalesOrderProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) => data.getOrderInvoices(
        context: context,
        orderId: widget.orderId,
        orderCode: widget.orderCode));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesOrderProvider>(builder: (context, salesData, _) {
      if (salesData.getOrderInvoiceStatus == ConnectionStatus.done) {
        var invoices = salesData.orderInvoiceModel.invoices;

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
                        AppLocalizations.of(context)!.invoice,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      invoices.length == 0
                          ? Text(
                        AppLocalizations.of(context)!.yetToInvoice,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            AppLocalizations.of(context)!.invoice,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)!.date,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)!.status,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)!.action,
                                        style: TextStyle(color: Colors.white),
                                      ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                ...invoices
                                    .map(
                                      (invoice) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      invoice.invoiceName)),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                invoice.invoiceDate,
                                              )),
                                              Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                                      color: Theme.of(context).primaryColor,),
                                                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                                                    child: 
                                                    Center(
                                                      child: Text(
                                                          invoice.paymentState,
                                                      style: TextStyle(color: Colors.white),),
                                                    ),
                                                  )),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () async {
                                                    var userProvider = Provider.of<AuthProvider>(context, listen: false);

                                                    FileDownloadService
                                                        service =
                                                        FileDownloadService();
                                                    showDialog(
                                                        context: context,
                                                        builder: (builder) {
                                                          return AlertDialog(
                                                              title: Row(
                                                            children: [
                                                              Text(
                                                                  "Downloading..."),
                                                              Spacer(),
                                                              CircularProgressIndicator(),
                                                            ],
                                                          ));
                                                        });
                                                    await service.downloadFile(
                                                        url:
                                                            "$baseUrl/api/downloadInvoicePdf",
                                                        headers: {
                                                          "Content-Type":
                                                              "application/json",
                                                          "Authorization":
                                                              "Bearer ${userProvider.userDetail.accessToken}",
                                                          "user_id":
                                                              userProvider
                                                                  .userDetail
                                                                  .userId
                                                                  .toString()
                                                        },
                                                        postBody: {
                                                          "order_invoice_id":
                                                              invoice
                                                                  .orderInvoiceId,
                                                          "order_code":
                                                              invoice.orderCode
                                                        },
                                                        name:
                                                            "invoice_${invoice.orderInvoiceId}.pdf");
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 4),

                                                      child: Icon(
                                                        Icons.download_outlined,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 22,
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                          if (invoices.indexOf(invoice) <
                                              invoices.length - 1)
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
                      "Invoices",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    Container(
                      height: 80,
                      child: Center(
                        child: Row(
                          children: [
                            Spacer(),
                            salesData.getOrderInvoiceStatus ==
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
