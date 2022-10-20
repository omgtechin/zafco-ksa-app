import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/routes.dart';
import '../../../../core/themes/app_theme.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
            "assets/app_icon.png",
            width: width * .4,
          ),
          automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Spacer(
              flex: 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .1),
              child: Image.asset("assets/delivery_truck.png"),
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              "Order  Successfully Placed",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).priceColor),
            ),
            Spacer(
              flex: 2,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Screen.mainScreen.toString(),arguments: {"pageId" : 1}, (_) {
                    return false;
                  });
                },
                child: Text(
                  "View Sales Orders",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      decoration: TextDecoration.underline),
                )),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
