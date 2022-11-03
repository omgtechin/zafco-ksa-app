import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/enum/connection_status.dart';
import '../../../../model/data_model/sales_order_detail_model.dart';

import '../../../../core/constant.dart';
import '../../../../provider/sales_order_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalesOrderPricing extends StatelessWidget {
  final List<OrderItems> orderItems;
  final String amountWithoutTax;
  final String taxAmount;
  final String totalAmount;
  final String orderId;
  final String orderCode;

  const SalesOrderPricing(
      {required this.orderItems,
      Key? key,
      required this.totalAmount,
      required this.amountWithoutTax,
      required this.taxAmount,
      required this.orderCode,
      required this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.pricing,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor),
            ),
            Spacer(),
            Consumer<SalesOrderProvider>(builder: (context, provider, _) {
              return InkWell(
                onTap: () {
                  provider.downloadProforma(
                      fileName: "proforma_$orderId.pdf",
                      url: "$baseUrl/api/downloadProformaPdf",
                      postBody: {"order_id": orderId, "order_code": orderCode},
                      context: context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  constraints: BoxConstraints(minWidth: 120),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: .8),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: provider.downloadPdfStatus == ConnectionStatus.active
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ))
                      : Text(
                    AppLocalizations.of(context)!.downloadProforma,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14),
                        ),
                ),
              );
            }),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          decoration: Constant().boxDecoration,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      AppLocalizations.of(context)!.products,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                          AppLocalizations.of(context)!.quantity,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.amount,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 1,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 8,
              ),
              ...orderItems
                  .map(
                    (item) => Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Text(
                                  item.name,
                                  style: TextStyle(fontSize: 13),
                                )),
                            Expanded(
                                child: Center(
                                    child: Text(
                              item.quantity.toString(),
                              style: TextStyle(fontSize: 14),
                            ))),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${item.totalAmount.toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 14),
                                    )))
                          ],
                        ),
                   if(orderItems.indexOf(item) != orderItems.length-1)  Column(
                          children: [
                            SizedBox(height: 6,),
                            DottedLine(
                              dashColor: Theme.of(context).primaryColor,
                            ),
                            SizedBox(height: 6,),
                          ],
                        )


                      ],
                    ),
                  )
                  .toList(),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 1,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.subTotal,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Spacer(),
                  Text(
                    "AED ${amountWithoutTax.toString()}",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              DottedLine(
                dashColor: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.vat5,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Spacer(),
                  Text(
                    "AED $taxAmount",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 1,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.total,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    "AED $totalAmount",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
