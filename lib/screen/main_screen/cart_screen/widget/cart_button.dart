import 'package:flutter/material.dart';

import '../../../../core/constant.dart';

class CartButton extends StatelessWidget {
  final String price;
  final Widget title;
  final Function onTap;

  const CartButton(
      {Key? key, required this.title, required this.price, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: Constant().boxDecoration,
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            price,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () => onTap(),
            child: title,
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                maximumSize: Size(200, 45),
                minimumSize: Size(150, 45)),
          )
        ],
      ),
    );
  }
}
