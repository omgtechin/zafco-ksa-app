import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../provider/shop_provider.dart';


class ShopSortModal extends StatelessWidget {
  const ShopSortModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getTitle(String title) {
      String lowerTitle = title.toLowerCase().trim();
      print(lowerTitle);
      if (lowerTitle == "price low to high") {
        return AppLocalizations.of(context)!.priceLowtoHigh;
      } else if (lowerTitle == "price high to low") {
        return AppLocalizations.of(context)!.priceHightoLow;
      } else if (lowerTitle == "stock") {
        return AppLocalizations.of(context)!.stock;
      } else if (lowerTitle == "clear sorting") {
        return  AppLocalizations.of(context)!.clearSorting;
      }
      return title;
    }

    return SingleChildScrollView(
      child: Consumer<ShopProvider>(builder: (context, shopProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: Text(
                AppLocalizations.of(context)!.sort,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: .4,
              color: Colors.grey.withOpacity(.5),
            ),
            SizedBox(
              height: 8,
            ),
            ...shopProvider.sortList.map((filter) {
              int currIdx = shopProvider.sortList.indexOf(filter);
              bool isSelected = shopProvider.selectedSortIdx ==currIdx
                  &&
                  shopProvider.selectedSortIdx < 3;
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop();

                  shopProvider.switchSort(index: currIdx);
                  if (filter.tag == "clear") {
                    shopProvider.loadShop(context: context);
                  } else {
                    shopProvider.getFilterData(context: context);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        getTitle(filter.title),
                        style: TextStyle(
                            fontSize: 15,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(
              height: 8,
            ),
          ],
        );
      }),
    );
  }
}
