import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zafco_ksa/provider/localization_provider.dart';

import '../../../../provider/invoice_provider.dart';

class InvoiceFilter extends StatelessWidget {
  const InvoiceFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizationProvider =
        Provider.of<LocalizationProvider>(context, listen: false);
    String getTitle(String title) {
      String lowerCase = title.toLowerCase();
      if (lowerCase == "all") {
        return AppLocalizations.of(context)!.all;
      } else if (lowerCase == "paid") {
        return AppLocalizations.of(context)!.paid;
      } else if (lowerCase == "in payment") {
        return AppLocalizations.of(context)!.inPayment;
      } else if (lowerCase == "partially paid") {
        return AppLocalizations.of(context)!.partiallyPaid;
      } else if (lowerCase == "reversed") {
        return AppLocalizations.of(context)!.reversed;
      } else if (lowerCase == "not paid") {
        return AppLocalizations.of(context)!.notPaid;
      } else {
        return title;
      }
    }

    return Consumer<InvoiceProvider>(builder: (context, invoiceProvider, _) {
      return Container(
        height: 35,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            if (localizationProvider.isLTR)
              SizedBox(
                width: 12,
              ),
            ...invoiceProvider.filters.map((filter) {
              int idx = invoiceProvider.filters.indexOf(filter);
              bool isSelected = idx ==
                  invoiceProvider.filterIdx;
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                  onTap: (){
                    invoiceProvider.applyFilter(index: idx, context: context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Text(
                      getTitle(filter.title),
                      style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              );
            }).toList(),
            if (!localizationProvider.isLTR)
              SizedBox(
                width: 12,
              ),
          ],
        ),
      );
    });
  }
}
