import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_bar.dart';
import '../../../../core/enum/connection_status.dart';
import '../../../../screen/main_screen/invoice/widget/invoice_filter.dart';
import '../../../../widget/loading_idicator.dart';
import '../../../core/enum/user_type.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/invoice_provider.dart';
import '../../../widget/customer_selector.dart';
import 'widget/invoice_card.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    var cart = Provider.of<CartProvider>(context, listen: false);
    var invoice = Provider.of<InvoiceProvider>(context, listen: false);
    var auth = Provider.of<AuthProvider>(context, listen: false);
    if (auth.userDetail.userType == UserType.employee) {
      auth.updateCustomer(updatedCustomerId: -1);
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      invoice.getInvoiceData(
          context: context,
        );
      cart.getCartCount(context: context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
        appBar: getAppBar(
            title: Text(
              AppLocalizations.of(context)!.invoices,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
                    var data =
                        Provider.of<InvoiceProvider>(context, listen: false);
                    data.getInvoiceData(
                      context: context,
                    );
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
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!.search,
                              ),
                              onSubmitted: (String? val) {
                                if (val != null) {
                                  var data = Provider.of<InvoiceProvider>(
                                      context,
                                      listen: false);
                                  data.applySearch(
                                      searchString: val, context: context);
                                }
                              },
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                if (_controller.text != "") {
                                  var data = Provider.of<InvoiceProvider>(
                                      context,
                                      listen: false);
                                  data.applySearch(
                                      searchString: _controller.text,
                                      context: context);
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
                                  var data = Provider.of<InvoiceProvider>(
                                      context,
                                      listen: false);
                                  data.clearSearchFilter(context: context);
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
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            InvoiceFilter(),
            SizedBox(
              height: 18,
            ),
            Expanded(
              child:
                  Consumer<InvoiceProvider>(builder: (context, invoiceData, _) {
                if (invoiceData.connectionStatus == ConnectionStatus.done) {
                  return invoiceData.invoiceModel.invoices.data.isEmpty
                      ? Center(
                    child: Text(
                              AppLocalizations.of(context)!.noInvoiceFound),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount:
                              invoiceData.invoiceModel.invoices.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Column(
                                  children: [
                                    InvoiceCard(
                                        invoiceData: invoiceData
                                            .invoiceModel.invoices.data[index]),
                                    if (index ==
                                            invoiceData.invoiceModel.invoices
                                                    .data.length -
                                                1 &&
                                        invoiceData.invoiceModel.invoices
                                                .lastPage !=
                                            invoiceData.invoiceModel.invoices
                                                .currentPage)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            "${AppLocalizations.of(context)!.showing} ${invoiceData.invoiceModel.invoices.from} ${AppLocalizations.of(context)!.to} ${invoiceData.invoiceModel.invoices.to} ${AppLocalizations.of(context)!.ofKey} ${invoiceData.invoiceModel.invoices.total} ${AppLocalizations.of(context)!.invoices}",
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
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      buttonShape:
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      buttonUnselectedForegroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      mode: ContentDisplayMode
                                                          .dropdown),
                                                  numberPages: invoiceData
                                                      .invoiceModel
                                                      .invoices
                                                      .lastPage,
                                                  initialPage: invoiceData
                                                          .invoiceModel
                                                          .invoices
                                                          .currentPage -
                                                      1,
                                                  onPageChange: (int index) {
                                                    invoiceData.getInvoiceData(
                                                        context: context,
                                                        pageIdx: index + 1);
                                                  },
                                                ),
                                                width: 160,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                  ],
                                ));
                          },
                        );
                } else if (invoiceData.connectionStatus ==
                    ConnectionStatus.error) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.wrongText),
                  );
                } else {
                  return Center(
                    child: LoadingIndicator(),
                  );
                }
              }),
            ),
          ],
        ));
  }
}
