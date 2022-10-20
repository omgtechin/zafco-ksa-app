import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String content;
  final bool enabled;

  const AddressCard({Key? key, required this.enabled, required this.content, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = enabled ? Theme.of(context).primaryColor : Colors.black.withOpacity(.8);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration:Constant().boxDecoration.copyWith(
          border: Border.all(color:enabled ? Theme.of(context).primaryColor : Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
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
              Spacer(),
              Icon(
                Icons.check_box_outlined,
                color: primaryColor,
              )
            ],
          ),
          SizedBox(height: 6,),
          Text(content,style: TextStyle(
            color: primaryColor
          ),)
        ],
      ),
    );
  }
}
