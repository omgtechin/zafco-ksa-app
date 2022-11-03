import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/adaptive/adaptive.dart';

import '../../../../model/data_model/shop_model.dart';
import '../../../../provider/shop_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShopFilterModal extends StatefulWidget {
  const ShopFilterModal({Key? key}) : super(key: key);

  @override
  State<ShopFilterModal> createState() => _ShopFilterModalState();
}

class _ShopFilterModalState extends State<ShopFilterModal> {
  @override
  Widget build(BuildContext context) {
    getAppliedList(List<FilterItem> filterList) {
      List<FilterItem> selectedFilter = [];
      for (var filter in filterList) {
        if (filter.isSelected) {
          selectedFilter.add(filter);
        }
      }
      return selectedFilter;
    }

    return Consumer<ShopProvider>(builder: (context, shopData, _) {
      var attributes = shopData.shopModel.attributes;

      String getLocation(String title) {
        String lowerTitle = title.toLowerCase().trim();
        if (lowerTitle == "all") {
          return AppLocalizations.of(context)!.allLocations;
        }
        return title;
      }

      String getFilterTitle(String title){
        String lowerTitle = title.toLowerCase().trim();
        if (lowerTitle == "select rim size") {
          return AppLocalizations.of(context)!.rimSize;
        }else if(lowerTitle == "select size"){
          return AppLocalizations.of(context)!.selectSize;
        }else if(lowerTitle == "select category"){
          return AppLocalizations.of(context)!.selectCategory;
        }else if(lowerTitle == "select pattern"){
          return AppLocalizations.of(context)!.selectTyrePattern;
        }else if(lowerTitle == "select brand"){
          return AppLocalizations.of(context)!.selectBrand;
        }else if(lowerTitle == "select segment"){
          return AppLocalizations.of(context)!.selectSegment;
        }else if(lowerTitle == "select year"){
          return AppLocalizations.of(context)!.selectProductionYear;
        }
        return title;
      }
      return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.filter,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        shopData.resetAllFilters();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.clearAll,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ))
                ],
              ),

              GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (builder){
                    return SelectLocationModal();
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 18),
                  padding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      border: Border.all(
                        color: Colors.black.withOpacity(.6),
                      )),
                  child: Row(
                    children: [
                      Text(

                          getLocation(
                        shopData.shopModel.location![shopData.selectedLocationIdx].title)),
                      Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.black.withOpacity(.6),

                      ),
                    ],
                  ),
                ),
              ),

              ...attributes!.map((filter) {
                return GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (context) => FilterItemModal(
                              filterList: filter.filterList,
                              title: filter.title,
                            ));

                    setState(() {});
                  },
                  child: Container(
                      margin: EdgeInsets.only(bottom: 18),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                            color: Colors.black.withOpacity(.6),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                getFilterTitle(  filter.title),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(.7)),
                              ),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.black.withOpacity(.6),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              ...getAppliedList(filter.filterList)
                                  .map((e) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            filter.filterList.remove(e);
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right: 8, top: 8),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 6),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                 e.title,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 18,
                                                )
                                              ],
                                            )),
                                      ))
                                  .toList()
                            ],
                          )
                        ],
                      )),
                );
              }).toList(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Provider.of<ShopProvider>(context, listen: false)
                      .getFilterData(context: context);
                },
                child: Text(
                  AppLocalizations.of(context)!.applyFilters,
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),
                    primary: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class FilterItemModal extends StatefulWidget {
  final List<FilterItem> filterList;
  final String title;

  const FilterItemModal(
      {Key? key, required this.filterList, required this.title})
      : super(key: key);

  @override
  State<FilterItemModal> createState() => _FilterItemModalState();
}

class _FilterItemModalState extends State<FilterItemModal> {
  @override
  Widget build(BuildContext context) {
    String getFilterTitle(String title){
      String lowerTitle = title.toLowerCase().trim();
      if (lowerTitle == "select rim size") {
        return AppLocalizations.of(context)!.rimSize;
      }else if(lowerTitle == "select size"){
        return AppLocalizations.of(context)!.selectSize;
      }else if(lowerTitle == "select category"){
        return AppLocalizations.of(context)!.selectCategory;
      }else if(lowerTitle == "select pattern"){
        return AppLocalizations.of(context)!.selectTyrePattern;
      }else if(lowerTitle == "select brand"){
        return AppLocalizations.of(context)!.selectBrand;
      }else if(lowerTitle == "select segment"){
        return AppLocalizations.of(context)!.selectSegment;
      }else if(lowerTitle == "select year"){
        return AppLocalizations.of(context)!.selectProductionYear;
      }
      return title;
    }
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          height: widget.filterList.length * 60.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Text(
                  getFilterTitle(widget.title),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 2,
                color: Colors.grey.withOpacity(.1),
              ),
              Expanded(
                child: Scrollbar(
                  radius: Radius.circular(18),
                 thumbVisibility: true,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.filterList.length,
                      itemBuilder: (context,index){
                   var filter = widget.filterList[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          filter.isSelected = !filter.isSelected;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Text(
                                  filter.title,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: filter.isSelected
                                          ? Theme.of(context)
                                          .primaryColor
                                          : Colors.black
                                          .withOpacity(.8),
                                      fontWeight: filter.isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey.withOpacity(.1),
                          ),
                        ],
                      ),
                    );
                  })

                ),
              ),
              Container(
                height: 1,
                color: Colors.grey.withOpacity(.1),
              ),
              Row(
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Apply",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class SelectLocationModal extends StatelessWidget {

  const SelectLocationModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shopProvider = Provider.of<ShopProvider>(context,listen: false);

    String getLocation(String title) {
      String lowerTitle = title.toLowerCase().trim();
      if (lowerTitle == "all") {
        return AppLocalizations.of(context)!.allLocations;
      }
      return title;
    }
    return  Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 14,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Text(
            "Select Location",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          height: 2,
          color: Colors.grey.withOpacity(.1),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...shopProvider.shopModel.location!.map((element) {
            bool  isSelected = shopProvider.selectedLocationIdx == shopProvider.shopModel.location!.indexOf(element);
              return  InkWell(
                onTap: (){
                  shopProvider.switchLocation(index: shopProvider.shopModel.location!.indexOf(element));
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        getLocation(element.title),
                        style: TextStyle(
                            fontSize: 14,
                            color:isSelected
                                ? Theme.of(context)
                                .primaryColor
                                : Colors.black
                                .withOpacity(.8),
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              );
            }),



          ],
        ),

       SizedBox(height: 12,)
      ],
    ));
  }
}
