import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../screen/auth_screen/widget/auth_input_field.dart';

import '../../core/enum/connection_status.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkboxValue = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/cover_img.png"), fit: BoxFit.fill)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .07,
            ),
            Image.asset(
              "assets/app_icon_white.png",
              height: 30,
            ),
            SizedBox(
              height: height * .04,
            ),
            Text(
              "Lets Sign you in.",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor.withOpacity(.9)),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Welcome Back",
              style:
                  TextStyle(color: Colors.white.withOpacity(.9), fontSize: 13),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "You Have Been Missed.",
              style:
                  TextStyle(color: Colors.white.withOpacity(.8), fontSize: 13),
            ),
            Spacer(),
            AuthInputField(
              inputController: emailController,
              inputType: TextInputType.emailAddress,
              hintText: "name@example.com",
              label: "Email",
            ),
            SizedBox(
              height: 20,
            ),
            AuthInputField(
              inputController: passwordController,
              inputType: TextInputType.emailAddress,
              hintText: "Enter your password",
              label: "Password",
            ),
            Row(
              children: [
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(Screen.forgotPasswordScreen.toString());
                    },
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.white),
                    ))
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
                        text: "First Time to zafco? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(.9),
                            fontSize: 13)),
                    WidgetSpan(
                        child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Screen.signInScreen.toString());
                      },
                      child: Text(
                        "Activate you account",
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
                child: Consumer<AuthProvider>(builder: (context, provider, _) {
                  return ElevatedButton(
                      onPressed: () async {
                        await provider.login(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context);
                      },
                      child: provider.connectionStatus == ConnectionStatus.none
                          ? Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            )
                          : CircularProgressIndicator(
                              color: Colors.white,
                            ));
                })),
            SizedBox(
              height: height * .08,
            )
          ],
        ),
      ),
    );
  }
}
