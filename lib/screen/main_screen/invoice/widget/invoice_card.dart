import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/data_model/invoice_model.dart';

import '../../../../core/constant.dart';
import '../../../../core/services/pdf_download_service.dart';
import '../../../../provider/auth_provider.dart';

class InvoiceCard extends StatelessWidget {
  final InvoiceData invoiceData;

  const InvoiceCard({Key? key, required this.invoiceData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constant _constants = Constant();
    buildDetails({required String title, required String data}) {
      return Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 2,
          ),
          Text(data)
        ],
      ));
    }

    return Container(
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
                height: 4,
              ),
              Text(
                "Invoice Number : ${invoiceData.invoiceCode}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  buildDetails(
                      title: "Invoice Date", data: invoiceData.invoiceDate),
                  buildDetails(
                      title: "Order Date",
                      data: invoiceData.createdAt.split("T")[0]),
                  buildDetails(
                      title: "Price", data: "AED ${invoiceData.price}"),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(
                      color:
                          _constants.getStatusColor(status: invoiceData.status,
                          )) ),

                    child: Center(
                      child: Text(
                          _constants.getFormattedString(str: invoiceData.status),
                          style: TextStyle(
                              color: _constants.getStatusColor(
                                  status: invoiceData.status))),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 35,
                    width: 120,
                    child: OutlinedButton(
                      onPressed: () async {
                        var userProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        FileDownloadService service = FileDownloadService();
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                  title: Row(
                                children: [
                                  Text("Downloading..."),
                                  Spacer(),
                                  CircularProgressIndicator(),
                                ],
                              ));
                            });
                        await service.downloadFile(
                            url: "$baseUrl/api/downloadInvoicePdf",
                            headers: {
                              "Content-Type": "application/json",
                              "Authorization":
                                  "Bearer ${userProvider.userDetail.accessToken}",
                              "user_id":
                                  userProvider.userDetail.userId.toString()
                            },
                            postBody: {
                              "order_invoice_id": invoiceData.invoiceId,
                              "order_code": invoiceData.invoiceCode
                            },
                            name: "invoice_${invoiceData.invoiceId}.pdf");
                        Navigator.of(context).pop();
                      },
                      child: Text("Download",style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ));
  }
}
