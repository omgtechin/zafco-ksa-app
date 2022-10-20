import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../screen/main_screen/cart_screen/widget/address_card.dart';

import '../../../../model/data_model/shipping_info_modal.dart';

class ShippingAddress extends StatefulWidget {
  final List<ShippingAddresses> shippingAddresses;

  const ShippingAddress({Key? key, required this.shippingAddresses})
      : super(key: key);

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: Constant().boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
          ),
          Text(
            "Shipping Address",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 12,
          ),
          ...provider.shippingDetailModel.shippingAddresses.map((address) {
            int index = provider.shippingDetailModel.shippingAddresses.indexOf(address);
            String detailedAddress = "${address.address}";
            return Column(
              children: [
                InkWell(
                    onTap: () {
                         setState(() {
                      provider.selectedShippingAddress = index;
                       });
                    },
                    child: AddressCard(
                      enabled: index == provider.selectedShippingAddress,
                      content: detailedAddress,
                      title: "Address ${index + 1}",
                    )),
                SizedBox(
                  height: 12,
                ),
              ],
            );
          }).toList()
        ],
      ),
    );
  }
}
