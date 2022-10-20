import 'package:flutter/material.dart';

import '../../../../core/constant.dart';
import '../widget/contact_us_form.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    buildDetailCard({required String title, required String data}) {
      return Container(
        decoration: Constant().boxDecoration,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      data,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Us",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            buildDetailCard(title: "Call Us", data: "+971 800-92326"),
            SizedBox(
              height: 12,
            ),
            buildDetailCard(title: "Mail Us", data: "uaesales@zafco.com"),
            SizedBox(
              height: 12,
            ),
            buildDetailCard(title: "Our Location", data: "ZAFCO, \nJebel Ali Free Zone (South), Dubai, United Arab Emirates"),
            SizedBox(
              height: 24,
            ),
          ContactUsForm(

      ), ],
        ),
      ),
    );
  }
}
