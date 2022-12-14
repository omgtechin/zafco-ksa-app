import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../screen/main_screen/cart_screen/widget/address_card.dart';

import '../../../../model/data_model/shipping_info_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.shippingAddress,
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
                    child:  AddressCard(
                      enabled: index == provider.selectedShippingAddress,
                      content: detailedAddress,
                      title: "Address ${index + 1}",
                      index: index,
                    )),
                SizedBox(
                  height: 12,
                ),
                if(provider.shippingDetailModel.shippingAddresses.length == 1)   Center(
                  child: TextButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: Text("Add new address"),
                              content: TextField(
                                controller: provider.newAddressController,
                                maxLines: 3,
                                decoration:
                                InputDecoration(border: OutlineInputBorder()),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                  style: TextButton.styleFrom(
                                      primary: Theme.of(context).primaryColor),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    provider.addNewAddress(
                                        address: provider.newAddressController.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Save"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor),
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add new address"),
                    style:
                    TextButton.styleFrom(primary: Theme.of(context).primaryColor),
                  ),
                ),

              ],
            );
          }).toList()
        ],
      ),
    );
  }
}
