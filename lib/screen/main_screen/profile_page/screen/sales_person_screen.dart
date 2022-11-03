import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant.dart';
import '../../../../core/enum/connection_status.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../widget/custom_icon_button.dart';
import '../../../../widget/loading_idicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SalesPersonScreen extends StatefulWidget {
  const SalesPersonScreen({Key? key}) : super(key: key);

  @override
  State<SalesPersonScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<SalesPersonScreen> {
  @override
  void initState() {
    var data = Provider.of<ProfileProvider>(context, listen: false);
    SchedulerBinding.instance
        .addPostFrameCallback((_) => data.getUserSalesPerson(context: context));

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.salesperson,

          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, data, _) {
        if (data.connectionStatus == ConnectionStatus.done) {
          var salesPerson = data.userSalesPersonModel.salesPerson;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(

      children:    [
            Container(
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
                              AppLocalizations.of(context)!.salesperson,
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
                                      AppLocalizations.of(context)!.sendMail,
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
            )
              ],
            ),
          );
        } else if (data.connectionStatus == ConnectionStatus.error) {
          return Center(
            child: Text(AppLocalizations.of(context)!.wrongText),
          );
        } else {
          return Center(
            child: LoadingIndicator(),
          );
        }
      }),
    );
  }
}
