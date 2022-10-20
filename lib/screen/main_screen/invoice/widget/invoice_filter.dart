import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/invoice_provider.dart';

class InvoiceFilter extends StatelessWidget {
  const InvoiceFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceProvider>(builder: (context, invoiceProvider, _) {
      return Container(
        height: 35,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
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
                      filter.title,
                      style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              );
            }).toList()
          ],
        ),
      );
    });
  }
}
