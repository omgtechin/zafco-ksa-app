import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/shop_provider.dart';


class ShopFilterTags extends StatelessWidget {
  const ShopFilterTags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shopProvider = Provider.of<ShopProvider>(context,);

    return Container(
      height: 35,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 12,
            ),
            ...shopProvider.tagList.map((filter) {
              int currIdx = shopProvider.tagList.indexOf(filter);
              bool isSelected = currIdx == shopProvider.selectedTagIdx;
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                  onTap: (){
                    shopProvider.selectedTagIdx = currIdx;
                    shopProvider.getFilterData(context: context);
                  },
                  child: Container(
                    child: Center(
                        child: Text(
                      filter.title,
                      style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                    )),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).primaryColor : null,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                  ),
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}

