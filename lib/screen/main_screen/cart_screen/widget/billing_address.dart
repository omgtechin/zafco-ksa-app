

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant.dart';
import '../../../../screen/main_screen/cart_screen/widget/address_card.dart';

class BillingAddress extends StatelessWidget {
  final String billingAddress;
  const BillingAddress({Key? key, required this.billingAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: Constant().boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: 18,),
          Text("Billing Address",style: TextStyle(
            fontSize: 18,fontWeight: FontWeight.w700,color: Theme.of(context).primaryColor
          ),),
          SizedBox(height: 12,),
          AddressCard(enabled: true, content: billingAddress, title: 'Address 1',),
          SizedBox(height: 18,),

        ],
      ),

    );
  }
}
