import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/cart_provider.dart';

import '../model/data_model/uesr_model.dart';
import '../provider/auth_provider.dart';

class CustomerSelector extends StatefulWidget {
  final VoidCallback onCustomerChange;
  final bool showAll;

  const CustomerSelector(
      {Key? key, required this.onCustomerChange, required this.showAll})
      : super(key: key);

  @override
  State<CustomerSelector> createState() => _CustomerSelectorState();
}

class _CustomerSelectorState extends State<CustomerSelector> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authData, _) {
      String getCustomerName(int id) {
        for (var customer in authData.userDetail.customers) {
          if (customer.id == id) {
            return customer.name;
          }
        }
        return "";
      }

      return InkWell(
        onTap: () async {
          Customer? customer = await showDialog(
              context: context,
              builder: (builder) => InputSelector(
                    customerList: [
                      if (widget.showAll)
                        Customer(id: -1, name: "All Customers"),
                      ...authData.userDetail.customers
                    ],
                  ));
          if (customer != null) {
            setState(() {});
            authData.updateCustomer(updatedCustomerId: customer.id);
            widget.onCustomerChange();
            Provider.of<CartProvider>(context, listen: false)
                .getCartCount(context: context);
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Theme.of(context).primaryColor)),
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: Text(authData.userDetail.customerId == -1
                    ? widget.showAll
                        ? "All Customer"
                        : "Select Customer"
                    : getCustomerName(authData.userDetail.customerId),style: TextStyle(
                  overflow: TextOverflow.ellipsis
                ),),
              ),

              Icon(Icons.arrow_drop_down),
              SizedBox(
                width: 12,
              )
            ],
          ),
        ),
      );
    });
  }
}

class InputSelector extends StatefulWidget {
  final List<Customer> customerList;

  const InputSelector({Key? key, required this.customerList}) : super(key: key);

  @override
  State<InputSelector> createState() => _InputSelectorState();
}

class _InputSelectorState extends State<InputSelector> {
  TextEditingController searchController = TextEditingController();
  List<Customer> filterList = [];

  updateList() {
    filterList = [];
    for (var customer in widget.customerList) {
      if (customer.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase())) {
        filterList.add(customer);
      }
    }
    print(filterList.length);
  }

  @override
  void initState() {
    filterList = widget.customerList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Material(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  child: TextField(
                    controller: searchController,
                    onChanged: (String val) {
                      setState(() {
                        updateList();
                      });
                    },
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: "Select Customer",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(.3),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: filterList.length,
                        itemBuilder: (itemBuilder, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context, filterList[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Text(
                                    filterList[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
