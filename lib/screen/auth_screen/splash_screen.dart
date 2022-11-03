

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zafco_ksa/provider/localization_provider.dart';

import '../../core/cache_client.dart';
import '../../core/routes.dart';
import '../../provider/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      init();
    });
    super.initState();
  }

  init() async {
  bool res =  await checkLanguage();
 if(res){
   await checkAuth();
    }
  }

  checkLanguage() async {
    print("check language");
    var localizationProvider =
        Provider.of<LocalizationProvider>(context, listen: false);
    String? local = await localizationProvider.getLocalFromStorage();
    print(local);
    print("language : $local");
    if (local == null) {
      Navigator.of(context)
          .pushReplacementNamed(Screen.languageSelectionScreen.toString());
      return false;
    } else {
      return true;
    }
  }

  checkAuth() async {
    try {
      var auth = Provider.of<AuthProvider>(context, listen: false);
      bool logedin = await auth.isUserLogedin;
      if (logedin) {
        CacheClient client = CacheClient();
        String loginKey = await client.getString(CashClientKey.loginKey) ?? "";
        String loginId = await client.getString(CashClientKey.loginId) ?? "";
        auth.login(email: loginId, password: loginKey, context: context);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(Screen.logInScreen.toString());
      }
    } catch (e) {
      Navigator.of(context).pushReplacementNamed(Screen.logInScreen.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/cover_img.png"), fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/app_icon.png",
            width: MediaQuery.of(context).size.width * .7,
          ),
          SizedBox(
            height: 28,
          ),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
