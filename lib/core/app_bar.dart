import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/routes.dart';
import '../../provider/cart_provider.dart';

import '../widget/custom_icon_button.dart';

AppBar getAppBar({required Widget title, required BuildContext context}) {
  return AppBar(
    centerTitle: false,
    title: title,
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Badge(
          badgeColor: Theme.of(context).primaryColor,
          badgeContent: Consumer<CartProvider>(
            builder: (context, provider,_) {
              return Text(
                provider.cartCount.toString(),
                style: TextStyle(color: Colors.white),
              );
            }
          ),
          child: CustomIconButton(
            icon: Icons.shopping_cart_outlined,
            onTap: () {
              Navigator.of(context).pushNamed(Screen.cartScreen.toString());
            },
          ),
        ),
      ),
      SizedBox(
        width: 12,
      ),
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Screen.profileScreen.toString());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color(0xff7E7E7E),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Image.asset(
                    "assets/icons/profile.png",
                  ),
                )),
          ),
        ),
      ),
      SizedBox(
        width: 8,
      ),
    ],
  );
}
