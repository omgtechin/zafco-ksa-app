import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../core/routes.dart';
import '../../provider/localization_provider.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizationProvider =
        Provider.of<LocalizationProvider>(context, listen: false);
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
              height: height * .05,
            ),
            Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(
              height: 16,
            ),
            ToggleSwitch(
              minWidth: 120,
              minHeight: 50,
              inactiveBgColor: Theme.of(context).primaryColor.withOpacity(.25),
              inactiveFgColor: Colors.white,
              initialLabelIndex: localizationProvider.getLocal == "en" ? 0 : 1,
              totalSwitches: 2,
              labels: [
                AppLocalizations.of(context)!.english,
                AppLocalizations.of(context)!.arabic,
              ],
              onToggle: (index) async {
                print(index);
                if (index != null) {
                  if (index == 0) {
                    await localizationProvider.switchLocal("en");
                  } else {
                    await localizationProvider.switchLocal("ar");
                  }
                }
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(Screen.initialScreen.toString());
              },
              child: Text(AppLocalizations.of(context)!.continueKey),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  minimumSize: Size(double.infinity, 50)),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
