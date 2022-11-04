import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zafco_ksa/core/constant.dart';
import 'package:zafco_ksa/provider/localization_provider.dart';
import 'package:zafco_ksa/screen/main_screen/profile_page/widget/language_selection_dialog.dart';

import '../../../../core/app_bar.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../screen/main_screen/profile_page/widget/profile_menu_card.dart';
import '../../../core/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getAppBar(
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,
            color: Colors.black),
          ),
          context: context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            ProfileMenuCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(Screen.personalDetailScreen.toString()),
                img: "assets/icons/personal_details.png",
                title: AppLocalizations.of(context)!.personalDetails),

            ProfileMenuCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(Screen.userOfferScreen.toString()),
                img: "assets/icons/offers.png",
                title: AppLocalizations.of(context)!.offers),
            ProfileMenuCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(Screen.catalogueScreen.toString()),
           img: "assets/icons/catalog.png",
                title: AppLocalizations.of(context)!.catalogue),
            ProfileMenuCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(Screen.salespersonScreen.toString()),
                img: "assets/icons/salesperson.png",
                title: AppLocalizations.of(context)!.salesperson),
            ProfileMenuCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(Screen.contactUsScreen.toString()),
                img: "assets/icons/ticket.png",
                title: AppLocalizations.of(context)!.contactUs),
            SizedBox(
              height: 24,
            ),
            OutlinedButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logOut(context: context);
                },
                child: Text(
                  AppLocalizations.of(context)!.logout,
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    minimumSize: Size(double.infinity, 50))),
            SizedBox(
              height: 18,
            ),
            OutlinedButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .deactivateAccount(context: context);
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    minimumSize: Size(double.infinity, 50)),
                child: Text(
                  AppLocalizations.of(context)!.deactivateAccount,
                  style: TextStyle(color: Colors.red),
                )),

            SizedBox(height: 20,),
            Text("Version: ${Constant().appVersion}",style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}
