import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../core/services/pdf_download_service.dart';
import '../../../../model/data_model/order_invoice_model.dart';
import '../../../../model/data_model/sales_order_detail_model.dart';
import '../../../../model/data_model/sales_order_model.dart';

import '../core/enum/connection_status.dart';
import '../model/data_model/order_detail_model.dart';
import 'auth_provider.dart';

class SalesOrderProvider with ChangeNotifier {
  ConnectionStatus getSalesOrdersStatus = ConnectionStatus.none;
  ConnectionStatus getSalesOrderDetailStatus = ConnectionStatus.none;
  ConnectionStatus downloadPdfStatus = ConnectionStatus.none;
  ConnectionStatus getOrderInvoiceStatus = ConnectionStatus.none;
  ConnectionStatus getOrderShippingStatus = ConnectionStatus.none;

  late SalesOrderModel salesOrderModel;
  late SalesOrderDetailModel salesOrderDetailModel;
  late OrderShippingModel orderShippingModel;
  late OrderInvoiceModel orderInvoiceModel;

  final Constant _constant = Constant();

  getSalesOrders({required BuildContext context, int? pageIndex}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "user_id": userProvider.userDetail.customerId == -1
            ? null
            : userProvider.userDetail.customerId,
        "user_type": userProvider.userDetail.userType.name,
        "customer": userProvider.userDetail.customerId == -1 ? false : true
      };
      print(postBody);
      getSalesOrdersStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/saleOrders?page=${pageIndex ?? 1}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );

      salesOrderModel = SalesOrderModel.fromJson(jsonDecode(response.body));
      getSalesOrdersStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      getSalesOrdersStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  applyFilter({required BuildContext context,required Map<String, dynamic> filter, int? pageIndex})async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "user_id": userProvider.userDetail.customerId == -1
            ? null
            : userProvider.userDetail.customerId,
        "user_type": userProvider.userDetail.userType.name,
        "customer": userProvider.userDetail.customerId == -1 ? false : true,
       ...filter
      };
      print(postBody);
      getSalesOrdersStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/saleOrders?page=${pageIndex ?? 1}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );

      salesOrderModel = SalesOrderModel.fromJson(jsonDecode(response.body));
      getSalesOrdersStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      getSalesOrdersStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  clearSearchFilter({required BuildContext context}) async {
    getSalesOrders(context: context);
  }

  getSalesOrderDetail(
      {required BuildContext context, required int orderId}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {"order_id": orderId};

      getSalesOrderDetailStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/getOrderDetails"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.customerId.toString()
        },
        body: jsonEncode(postBody),
      );

      salesOrderDetailModel =
          SalesOrderDetailModel.fromJson(jsonDecode(response.body));
      getSalesOrderDetailStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      getSalesOrderDetailStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  getOrderInvoices({
    required BuildContext context,
    required int orderId,
    required String orderCode,
  }) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "order_id": orderId,
        "order_code": orderCode,
      };
      getOrderInvoiceStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/getOrderInvoices"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.customerId.toString()
        },
        body: jsonEncode(postBody),
      );
      orderInvoiceModel = OrderInvoiceModel.fromJson(jsonDecode(response.body));
      getOrderInvoiceStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      getOrderInvoiceStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  getDeliveryOrders(
      {required BuildContext context,
      required int id,
      required String orderCode,
      required int orderId}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "order_id": id,
        "order_code": orderCode,
        "oddo_order_id": orderId
      };

      print(jsonEncode(postBody));
      getOrderShippingStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/getOrderShippings"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.customerId.toString()
        },
        body: jsonEncode(postBody),
      );

      orderShippingModel =
          OrderShippingModel.fromJson(jsonDecode(response.body));
      getOrderShippingStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      getOrderShippingStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  downloadProforma(
      {required String url,
      required Map<String, dynamic> postBody,
      required BuildContext context,
      required String fileName}) async {
    FileDownloadService service = FileDownloadService();

    try {
      downloadPdfStatus = ConnectionStatus.active;
      notifyListeners();
      var userProvider = Provider.of<AuthProvider>(context, listen: false);

      await service
          .downloadFile(url: url, name: fileName, postBody: postBody, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
        "user_id": userProvider.userDetail.customerId.toString()
      });
    } catch (e) {
      _constant.getToast(title: "Something went wrong!");
      log(e.toString());
    } finally {
      downloadPdfStatus = ConnectionStatus.none;
      notifyListeners();
    }
  }
}
