import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalesSortFilterModal extends StatefulWidget {
  const SalesSortFilterModal({Key? key}) : super(key: key);

  @override
  State<SalesSortFilterModal> createState() => _SalesSortFilterModalState();
}

class _SalesSortFilterModalState extends State<SalesSortFilterModal> {
  List<SortOrderModel> orderFilterList = [
    SortOrderModel(title: "Date", filterList: [
      FilterItem(title: "Date latest First", isSelected: false),
      FilterItem(title: "Date older fist", isSelected: false),
    ]),
    SortOrderModel(title: "Alphabetical Order", filterList: [
      FilterItem(title: "a to z", isSelected: false),
      FilterItem(title: "z to a", isSelected: false),
    ]),
    SortOrderModel(title: "Status", filterList: [
      FilterItem(title: "Order created", isSelected: false),
      FilterItem(title: "Pending for credit check", isSelected: false),
      FilterItem(title: "Pending for delivery", isSelected: false),
      FilterItem(title: "Invoiced", isSelected: false),
    ]),
    SortOrderModel(title: "Price", filterList: [
      FilterItem(title: "High to Low", isSelected: false),
      FilterItem(title: "Low to High", isSelected: false),
    ]),
    SortOrderModel(title: "Order Type", filterList: [
      FilterItem(title: "Local", isSelected: false),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Text(
                  "Sort By",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                TextButton(onPressed: () {}, child: Text("Clear All"))
              ],
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(.3),
            height: .5,
            width: double.infinity,
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...orderFilterList
                    .map((filter) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filter.title,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Wrap(
                              children: filter.filterList
                                  .map((filterItem) => Padding(
                                        padding: EdgeInsets.only(
                                            right: 8, bottom: 8),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              filterItem.isSelected =
                                                  !filterItem.isSelected;
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: filterItem.isSelected
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      width: .8)),
                                              child: Text(
                                                filterItem.title,
                                                style: TextStyle(
                                                  color: filterItem.isSelected
                                                      ? Colors.white
                                                      : Theme.of(context)
                                                          .primaryColor,
                                                ),
                                              )),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ))
                    .toList(),
                Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      child: Text(
                        AppLocalizations.of(context)!.applyFilters,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 18,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SortOrderModel {
  final String title;
  final List<FilterItem> filterList;

  SortOrderModel({required this.title, required this.filterList});
}

class FilterItem {
  final String title;
  bool isSelected;

  FilterItem({required this.title, required this.isSelected});
}
