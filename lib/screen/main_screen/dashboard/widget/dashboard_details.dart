import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/adaptive/adaptive.dart';
import '../../../../core/constant.dart';
import '../../../../core/enum/user_type.dart';
import '../../../../model/data_model/dashboard_model.dart';
import '../../../../provider/auth_provider.dart';

import '../../../../core/services/pdf_download_service.dart';
import '../../../../widget/custom_icon_button.dart';

class DashboardDetails extends StatelessWidget {
  final DashboardModel dashboard;

  const DashboardDetails({Key? key, required this.dashboard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCustomer =
        Provider.of<AuthProvider>(context, listen: false).userDetail.userType ==
            UserType.customer;
    var data = dashboard.dashboard.customerData!;
    buildSquareCard({required String title, required String data, String? subTitle, Color? color}) {
      return Expanded(
        child: Container(
          height: 60.h,
          decoration: Constant().boxDecoration,
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
                    Spacer(),
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13, )),
                    Text(subTitle??"",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 10.5,color: Colors.black.withOpacity(.9))),
                    Spacer(
                      flex: 4,
                    ),
                    Text(
                      data,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700,color: color),
                    ),
                    Spacer(flex: 2,),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    buildRectangleCard() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 40.h,
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
            Text(
              "Next Payment Due Date",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Text(
              data.nextPaymentDueDate,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            SizedBox(
              width: 12,
            ),
          ],
        ),
      );
    }

    buildStatementOfAccount() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 40.h,
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
            Text(
              "Statement of Account",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Container(
              height: 38,
              width: 160,
              child: OutlinedButton(


                onPressed: () async {

             var pickedDate =   await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now());
               if(pickedDate != null){
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
                 String date =
                 formatDate(pickedDate, [yyyy, '-', mm, '-', dd]);
                 await service.downloadFile(
                     url: "$baseUrl/api/downloadSOA",
                     headers: {
                       "Content-Type": "application/json",
                       "Authorization":
                       "Bearer ${userProvider.userDetail.accessToken}",
                       "user_id": userProvider.userDetail.userId.toString()
                     },
                     postBody: {

                       "user_id": userProvider.userDetail.userId.toString(),
                       "date": date
                     },
                     name: "account_statement_${userProvider.userDetail.userId}.pdf");
                 Navigator.of(context).pop();
               }

                },
                child: Text("Download SOA"),
                style: OutlinedButton.styleFrom(),
              ),
            ),
            SizedBox(
              width: 12,
            ),
          ],
        ),
      );
    }

    buildSalesPerson() {
      var data = dashboard.dashboard.customerData;
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
                          onTap: () {
                            Constant().sendMail(
                                emailId: data?.salesPersonEmailId ?? "");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6),
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
                        Container(
                          height: 30,
                          width: 30,
                          child: Material(
                              color: Colors.redAccent,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Image.asset(
                                  "assets/icons/profile.png",
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          data?.salesPerson ?? "",
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
                          data?.salesPersonEmailId ?? "",
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
                          data?.salesPersonPhoneNo ?? "",
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              buildSquareCard(
                  title: "Orders", data: data.salesOrder.toString(),subTitle: "(Current Year Only)"),
              SizedBox(
                width: 12,
              ),
              buildSquareCard(
                  title: "Statement of Account", data: data.statementOfAccount),
              SizedBox(
                width: 12,
              ),
              buildSquareCard(title: "Ticket", data: data.tickets),
            ],
          ),
          if (isCustomer)
            SizedBox(
              height: 12,
            ),
          if (isCustomer) buildSalesPerson(),
          if (isCustomer)
            SizedBox(
              height: 12,
            ),
          if (isCustomer) buildStatementOfAccount(),
          SizedBox(
            height: 12,
          ),
          buildRectangleCard(),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              buildSquareCard(title: "Invoice", data: data.invoices.toString(),subTitle: "(Current Year Only)"),
              SizedBox(
                width: 12,
              ),
              buildSquareCard(
                  title: "Current Outstanding", data:"AED " + data.currentOutstanding),
              SizedBox(
                width: 12,
              ),
              buildSquareCard(title: "Overdue", data:"AED "+ data.overdue , color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
