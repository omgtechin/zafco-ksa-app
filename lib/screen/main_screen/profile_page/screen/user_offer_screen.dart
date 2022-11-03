import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/enum/connection_status.dart';
import '../../../../core/routes.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../widget/loading_idicator.dart';

class UserOfferScreen extends StatefulWidget {
  const UserOfferScreen({Key? key}) : super(key: key);

  @override
  State<UserOfferScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<UserOfferScreen> {
  @override
  void initState() {
    var data = Provider.of<ProfileProvider>(context, listen: false);
    SchedulerBinding.instance
        .addPostFrameCallback((_) => data.getUserOffer(context: context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.offers,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,color: Colors.black),
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, data, _) {
        if (data.connectionStatus == ConnectionStatus.done) {
          var offers = data.offerModel.offers;
          return offers.isEmpty
              ? Center(
            child: Text(AppLocalizations.of(context)!.noOfferFound),
          )
              : SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                ...offers
                    .map((offer) => Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                          Screen.mainScreen.toString(),
                          arguments: {"pageId": 3,"filterType": "offers", "filter": offer.offerBrands});
                    },
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.all(Radius.circular(18)),
                      child: Image.network(offer.offerImage),
                    ),
                  ),
                ))
                    .toList()
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
