import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../core/constant.dart';
import '../../model/data_model/cart_model.dart';
import '../../provider/shop_provider.dart';
import '../core/enum/connection_status.dart';
import '../core/routes.dart';
import '../model/data_model/shipping_info_modal.dart';
import 'auth_provider.dart';

class CartProvider with ChangeNotifier {
  ConnectionStatus connectionStatus = ConnectionStatus.none;
  ConnectionStatus buttonLoadingStatus = ConnectionStatus.none;

  late CartModel cartModel;
  late int cartCount = 0;
  late ShippingDetailModel shippingDetailModel;
  int selectedShippingAddress = 0;
  String deliveryType = "Delivery";

  TextEditingController newAddressController = TextEditingController();

  final Constant _constant = Constant();

  loadCartPage({required BuildContext context}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "user_id": userProvider.userDetail.customerId,
        "user_type": userProvider.userDetail.userType.name
      };

      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/cartDetail"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      getCartCount(context: context);
      print(response.body);
      cartModel = CartModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      print(e);
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  loadShippingDetailsPage({required BuildContext context}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "user_id": userProvider.userDetail.customerId,
        "user_type": userProvider.userDetail.userType.name
      };
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/setUserDetails"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      print(response.body);
      shippingDetailModel =
          ShippingDetailModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      connectionStatus = ConnectionStatus.error;
      log("load cart error : $e");
    } finally {
      notifyListeners();
    }
  }

  updateCart(
      {required BuildContext context,
      required int quantity,
      required int productIdProdYear}) async {
    try {
      var shopProvider = Provider.of<ShopProvider>(context, listen: false);
      await shopProvider.addProductToCart(
          quantity: quantity,
          productIdProdYear: productIdProdYear,
          context: context);
      await loadCartPage(context: context);
    } catch (e) {
      _constant.getToast(title: AppLocalizations.of(context)!.wrongText);
    }
  }

  deleteProductFromCart(
      {required BuildContext context, required int productId, required int qty}) async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);

    var postBody = {
      "product_id": productId,
      "user_type": userProvider.userDetail.userType.name,
      "user_id": userProvider.userDetail.customerId
    };

    try {
      await http.post(
        Uri.parse("$baseUrl/api/removeFromCart"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      cartCount = cartCount - qty;
      await loadCartPage(context: context);
    } catch (e) {
      _constant.getToast(title: AppLocalizations.of(context)!.wrongText);
    }
  }

  clearCart({required BuildContext context}) async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);
    var postBody = {
      "user_type": userProvider.userDetail.userType.name,
      "user_id": userProvider.userDetail.customerId
    };

    try {
      await http.post(
        Uri.parse("$baseUrl/api/clearCart"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      cartCount = 0;
      await loadCartPage(context: context);
    } catch (e) {
      _constant.getToast(title: AppLocalizations.of(context)!.wrongText);
    }
  }

  checkout({required BuildContext context}) async {
    try {
      buttonLoadingStatus = ConnectionStatus.active;
      notifyListeners();
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      Map<String, dynamic> postBody = {
        "user_id": userProvider.userDetail.customerId,
        "user_type": userProvider.userDetail.userType.name,
        "selected_shipping_address": shippingDetailModel
            .shippingAddresses[selectedShippingAddress].customerId,
        "selected_billing_address":
        shippingDetailModel.billingAddress.customerId,
        "delivery_type": deliveryType.toLowerCase(),
      };

      print(jsonEncode(postBody));
      var response = await http.post(
        Uri.parse("$baseUrl/api/saveOrder"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString(),
          "user_type" : userProvider.userDetail.userType.name
        },
        body: jsonEncode(postBody),
      );

      Map<String, dynamic> orderResponse = jsonDecode(response.body);
      print(orderResponse);
      if(orderResponse["success"] != null && orderResponse["success"] == true){
        Constant().getToast(title: orderResponse["msg"]);
        Navigator.of(context)
            .pushReplacementNamed(Screen.orderPlacedScreen.toString());
      }else{
        if(orderResponse["msg"] != null){
          Constant().getToast(title: orderResponse["msg"]);
        }else{
          Constant().getToast(title:AppLocalizations.of(context)!.wrongText);
        }
      }
      buttonLoadingStatus = ConnectionStatus.done;
      notifyListeners();
    } catch (e) {
      buttonLoadingStatus = ConnectionStatus.error;
      _constant.getToast(title: AppLocalizations.of(context)!.wrongText);
    } finally {
      notifyListeners();
    }
  }

  addNewAddress({required String address}) {
    shippingDetailModel = ShippingDetailModel(
        orderQuantity: shippingDetailModel.orderQuantity,
        billingAddress: shippingDetailModel.billingAddress,
        shippingAddresses: [
          ...shippingDetailModel.shippingAddresses,
          ShippingAddresses(address: address, customerId: null)
        ]);
    selectedShippingAddress = 1;
    notifyListeners();
  }

  editNewAddress({required String address, required int index}) {
    shippingDetailModel.shippingAddresses.removeAt(index);
    shippingDetailModel.shippingAddresses
        .add(ShippingAddresses(address: address, customerId: null));
    shippingDetailModel = ShippingDetailModel(
        orderQuantity: shippingDetailModel.orderQuantity,
        billingAddress: shippingDetailModel.billingAddress,
        shippingAddresses: shippingDetailModel.shippingAddresses);

    notifyListeners();
  }

  deleteNewAddress({required int index}) {
    shippingDetailModel.shippingAddresses.removeAt(index);
    shippingDetailModel = ShippingDetailModel(
        orderQuantity: shippingDetailModel.orderQuantity,
        billingAddress: shippingDetailModel.billingAddress,
        shippingAddresses: shippingDetailModel.shippingAddresses);
    selectedShippingAddress = 0;
    notifyListeners();
  }

  getCartCount({required BuildContext context}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "user_id": userProvider.userDetail.customerId,
        "user_type": userProvider.userDetail.userType.name
      };

      var response = await http.post(
        Uri.parse("$baseUrl/api/setUserDetails"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      print("cart count");
      print(response.body);

      if (jsonDecode(response.body) == "Your cart is empty") {
        cartCount = 0;
      } else {
        cartCount =
            jsonDecode(response.body)["order_quantity"]["total_quantity"];
      }
    } catch (e) {
      print("cart count error");
      print(e);
    }finally{
      notifyListeners();
    }
  }
}
