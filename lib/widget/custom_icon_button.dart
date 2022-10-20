

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  double? size;

   CustomIconButton({Key? key, required this.icon, required this.onTap, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(

      elevation: 2,
        shape:
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: InkWell(
          onTap: ()=>onTap(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
            ),
           width: size ?? 40,
            height: size ?? 40,

            child: Center(
              child: Icon(
               icon,size: size == null? 24 :size! * 0.6,
                color: Theme.of(context).primaryColor.withOpacity(.8),
              ),
            ),
          ),
        ));
  }
}
