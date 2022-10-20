import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          context: context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            ProfileMenuCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(Screen.personalDetailScreen.toString()),
                img: "assets/icons/personal_details.png",
                title: "Personal Details"),
            ProfileMenuCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(Screen.userOfferScreen.toString()), img: "assets/icons/offers.png", title: "Offers"),
            ProfileMenuCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(Screen.catalogueScreen.toString()),
                img: "assets/icons/cart.png",
                title: "Catalogue"),
            ProfileMenuCard(  onTap: () => Navigator.of(context)
                .pushNamed(Screen.salespersonScreen.toString()),
                img: "assets/icons/salesperson.png",
                title: "Salesperson"),
            ProfileMenuCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(Screen.contactUsScreen.toString()), img: "assets/icons/ticket.png", title: "Contact Us"),
            SizedBox(
              height: 24,
            ),
            OutlinedButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logOut(context: context);
                },
                child: Text(
                  "Logout",
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
                child: const Text(
                  "Deactivate Account",
                  style: TextStyle(color: Colors.red),
                )),
          ],
        ),
      ),
    );
  }
}
