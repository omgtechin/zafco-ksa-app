import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../provider/cart_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShippingInfo extends StatefulWidget {
  const ShippingInfo({Key? key}) : super(key: key);

  @override
  State<ShippingInfo> createState() => _ShippingInfoState();
}

class _ShippingInfoState extends State<ShippingInfo> {
  List<String> deliveryType = ["Delivery", "Pickup"];
  String selected = "Delivery";

  @override
  Widget build(BuildContext context) {
    String getDeliveryType(String title){
      String lowerTitle =  title.toLowerCase().trim();
      if(lowerTitle == "delivery"){
        return     AppLocalizations.of(context)!.delivery;
      }else if(lowerTitle == "pickup"){
        return  AppLocalizations.of(context)!.pickup;
      }
      return title;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: Constant().boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            AppLocalizations.of(context)!.shippingInfo,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
              AppLocalizations.of(context)!.pONumber,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            padding: EdgeInsets.only(left: 8,right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all()),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText:     AppLocalizations.of(context)!.enterPONumber, border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
              AppLocalizations.of(context)!.deliveryType,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            padding: EdgeInsets.only(left: 8,right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all()),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              value: selected,
              items: deliveryType
                  .map((label) => DropdownMenuItem(
                        child: Text(getDeliveryType(label)),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    Provider.of<CartProvider>(context,listen: false).deliveryType = value;
                    selected = value;
                  });
                }
              },
            ),
          ),
          SizedBox(
            height: 18,
          )
        ],
      ),
    );
  }
}
