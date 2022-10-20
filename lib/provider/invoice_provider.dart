import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../core/enum/user_type.dart';
import '../../../../model/user_defiend_model/shop_tag.dart';

import '../core/enum/connection_status.dart';
import '../model/data_model/invoice_model.dart';
import 'auth_provider.dart';

class InvoiceProvider with ChangeNotifier {
  ConnectionStatus connectionStatus = ConnectionStatus.none;
  late InvoiceModel invoiceModel;

  int filterIdx = 0;

  List<ShopTag> filters = [
    ShopTag(title: "All", tag: "invoice_paid"),
    ShopTag(title: "Paid", tag: "invoice_paid"),
    ShopTag(title: "In Payment", tag: "invoice_in_payment"),
    ShopTag(title: "Partially Paid", tag: "invoice_partially_paid"),
    ShopTag(title: "Reversed", tag: "invoice_reversed"),
    ShopTag(title: "Not Paid", tag: "invoice_not_paid"),
  ];

  getInvoiceData({required BuildContext context, int? pageIdx}) async {
    filterIdx = 0;
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "user_id": userProvider.userDetail.customerId == -1
            ? null
            : userProvider.userDetail.customerId,
        "user_type": userProvider.userDetail.userType.name,
        "customer": userProvider.userDetail.customerId == -1 ? false : true
      };
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/getInvoices?page=${pageIdx ?? 1}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      print(response.body);
      invoiceModel = InvoiceModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  applyFilter({required int index, required BuildContext context}) async {
    filterIdx = index;
    notifyListeners();
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "user_id": userProvider.userDetail.customerId == -1
            ? null
            : userProvider.userDetail.customerId,
        "user_type": userProvider.userDetail.userType.name,
        "customer": userProvider.userDetail.customerId == -1 ? false : true,
        filters[index].tag: 1,
      };
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/getInvoices"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      invoiceModel = InvoiceModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  applySearch(
      {required String searchString, required BuildContext context}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "user_id": userProvider.userDetail.customerId == -1
            ? null
            : userProvider.userDetail.customerId,
        "user_type": userProvider.userDetail.userType.name,
        "customer": userProvider.userDetail.customerId == -1 ? false : true,
        "search": searchString,
      };
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/getInvoices"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      invoiceModel = InvoiceModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  clearSearchFilter({required BuildContext context}) async {
    getInvoiceData(context: context);
  }
}
