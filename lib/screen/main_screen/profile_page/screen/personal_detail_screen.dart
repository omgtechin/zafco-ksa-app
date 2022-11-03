import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';

import '../../../../core/enum/connection_status.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../widget/loading_idicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalDetailScreen extends StatefulWidget {
  const PersonalDetailScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  @override
  void initState() {
    var data = Provider.of<ProfileProvider>(context, listen: false);
    SchedulerBinding.instance
        .addPostFrameCallback((_) => data.getPersonalDetail(context: context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildDetailCard({required String title, required String subTitle}) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: Constant().boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      );
    }

    buildAddressCard({required String title, required String subTitle}){
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),

        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.8),
          width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700 ),),
            SizedBox(height: 4,),
            Text(subTitle,style: TextStyle(color: Theme.of(context).primaryColor),),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.personalDetails,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, data, _) {
        if (data.connectionStatus == ConnectionStatus.done) {
          var userData = data.personalDetailModel.userData;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: 16,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  width: double.infinity,
                  decoration: Constant().boxDecoration,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.personalDetails,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        buildDetailCard(
                            title: AppLocalizations.of(context)!.email, subTitle: userData.email ?? ""),
                        SizedBox(
                          height: 12,
                        ),
                        buildDetailCard(
                            title: AppLocalizations.of(context)!.phoneNumber, subTitle: userData.phone),
                      ]),
                ),
                SizedBox(
                  height: 28,
                ),
                if(userData.billingAddress != "")       Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  width: double.infinity,
                  decoration: Constant().boxDecoration,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      AppLocalizations.of(context)!.billingAddress,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 12,),

                        buildAddressCard(title: "Address 1",
                        subTitle:userData.billingAddress )
                      ]),
                ),

                SizedBox(
                  height: 28,
                ),
          if(userData.shippingAddresses.isNotEmpty)      Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  width: double.infinity,
                  decoration: Constant().boxDecoration,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.shippingAddress,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 12,),

                        ...userData.shippingAddresses.map((address) {
                          int idx = userData.shippingAddresses.indexOf(address);
                          return buildAddressCard(title: "Address ${idx + 1}",
                            subTitle:userData.billingAddress );
                        }
                        )]),
                ),
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
