import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String label;
  final String hintText;
  TextInputType? inputType;
  final TextEditingController inputController ;

  AuthInputField({
    Key? key,
    required this.label,
    required this.inputType,
    required this.hintText,
    required this.inputController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14,fontWeight: FontWeight.w700),
            ),
            Spacer(),

          ],
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: TextField(obscureText: label.toLowerCase() == "password",
            controller: inputController,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
            keyboardType: inputType,
          ),
        ),
      ],
    );
  }
}
