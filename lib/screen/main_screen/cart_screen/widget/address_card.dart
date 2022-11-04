import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant.dart';
import '../../../../provider/cart_provider.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String content;
  final bool enabled;
  final int index;

  const AddressCard(
      {Key? key,
        required this.enabled,
        required this.content,
        required this.title,
        required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context,listen: false);
    var primaryColor =
    enabled ? Theme.of(context).primaryColor : Colors.black.withOpacity(.8);
    bool showButton = index != 0;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: Constant().boxDecoration.copyWith(
              border: Border.all(
                  color: enabled
                      ? Theme.of(context).primaryColor
                      : Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                        fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                content,
                style: TextStyle(color: primaryColor),
              )
            ],
          ),
        ),
        if (enabled)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(4))),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        if (showButton)
          Positioned(
              top: 0,
              right: 8,
              child: Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {
                      cartProvider.deleteNewAddress(index: index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.delete_outlined,
                        color: primaryColor,
                        size: 22,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  InkWell(
                      onTap: () {

                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                title: Text("Edit address"),
                                content: TextField(
                                  controller: cartProvider.newAddressController,
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
                                      cartProvider.editNewAddress(
                                          index: index,
                                          address: cartProvider.newAddressController.text);
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
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.edit_outlined,
                          color: primaryColor,
                          size: 20,
                        ),
                      ))
                ],
              ))
      ],
    );
  }
}
