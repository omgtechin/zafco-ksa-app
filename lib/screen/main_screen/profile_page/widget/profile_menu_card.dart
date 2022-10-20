

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant.dart';

class ProfileMenuCard extends StatelessWidget {
  final String img;
  final String title;
  final VoidCallback onTap;
  const ProfileMenuCard({Key? key, required this.img, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Container(

          decoration: Constant().boxDecoration,
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),

          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Theme.of(context).primaryColor)
                ),
                child: Image.asset(img,height: 20, width: 20,),),
              SizedBox(width: 12,),
              Expanded(child: Text(title,
              style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),))
            ],
          ),
        ),
      ),
    );
  }
}
