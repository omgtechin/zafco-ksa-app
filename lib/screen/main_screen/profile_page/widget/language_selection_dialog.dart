import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../provider/localization_provider.dart';

class LanguageSelectionModal extends StatefulWidget {
  const LanguageSelectionModal({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionModal> createState() => _LanguageSelectionModalState();
}

class _LanguageSelectionModalState extends State<LanguageSelectionModal> {
  int selectedIdx = 0;

  @override
  void initState() {
    var provider = Provider.of<LocalizationProvider>(context, listen: false);

    selectedIdx = provider.isLTR ? 0 : 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocalizationProvider>(context, listen: false);

    List<String> langList = ["English", "العربية"];

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.selectLanguage),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: langList
            .map((language) => InkWell(
                  onTap: () {
                    int index = langList.indexOf(language);

                    setState(() {
                      selectedIdx = index;
                    });
                    if (index == 0) {
                      provider.switchLocal("en");
                    } else {
                      provider.switchLocal("ar");
                    }
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Text(language,
                            style: TextStyle(
                                color: selectedIdx == langList.indexOf(language)
                                    ? Theme.of(context).primaryColor
                                    : Colors.black,
                                fontWeight: FontWeight.w700)),
                        Spacer(),
                        selectedIdx == langList.indexOf(language)
                            ? Icon(
                                Icons.radio_button_checked_sharp,
                                color: Theme.of(context).primaryColor,
                              )
                            : Icon(Icons.radio_button_off)
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
