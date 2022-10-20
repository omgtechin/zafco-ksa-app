import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../screen/auth_screen/widget/auth_input_field.dart';

import '../../provider/auth_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  String message = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/cover_img.png"), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .07,
            ),
            Image.asset(
              "assets/app_icon_white.png",
              height: 30,
            ),
            Spacer(),
            SizedBox(
              height: height * .04,
            ),
            Text(
              "Activate your \nAccount",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor.withOpacity(.9)),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Enter your email and we will send the steps to activate your account.",
              style:
                  TextStyle(color: Colors.white.withOpacity(.8), fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            AuthInputField(
              inputController: emailController,
              inputType: TextInputType.emailAddress,
              hintText: "name@example.com",
              label: "Email",
            ),
            SizedBox(height: 20,),

        if(message != "")    Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle,color: Colors.white70,size: 16,),
                SizedBox(width: 12,),
            
                Expanded(
                  child: Text(message,style: TextStyle(
                    color: Colors.red.shade100
                  ),),
                ),
              ],
            ),
            Spacer(
              flex: 5,
            ),
            Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Already a zafco member? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(.9),
                            fontSize: 13)),
                    WidgetSpan(
                        child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        "Login now!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )),
                  ])),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      var auth = Provider.of<AuthProvider>(context,listen: false);
                      String msg = await auth.activateAccount(
                          email: emailController.text);
                      message = msg;
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Activate Account",
                            style: TextStyle(color: Colors.white),
                          ))),
            SizedBox(
              height: height * .08,
            )
          ],
        ),
      ),
    );
  }
}
