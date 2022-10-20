import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../core/constant.dart';
import '../../model/data_model/shop_model.dart';
import '../../provider/cart_provider.dart';

import '../core/enum/connection_status.dart';
import '../model/user_defiend_model/shop_tag.dart';
import 'auth_provider.dart';

class ShopProvider with ChangeNotifier {
  ConnectionStatus connectionStatus = ConnectionStatus.none;
  late ShopModel shopModel;
  final Constant _constant = Constant();
  int selectedLocationIdx = 0;
  bool showWhereHouse = true;
  final TextEditingController searchController = TextEditingController();

  // for top bar filter switch
  int selectedTagIdx = 0;
  List<ShopTag> tagList = [
    ShopTag(title: "All", tag: "all"),
    ShopTag(title: "Favourites", tag: "favourite"),
    ShopTag(title: "Frequently Brought", tag: "frequent"),
    ShopTag(title: "Best Sellers", tag: "best"),
    ShopTag(title: "Offers", tag: "offer"),
  ];

  //for sort product
  int selectedSortIdx = -1;
  List<ShopTag> sortList = [
    ShopTag(title: "Price Low to High", tag: 'orderByPriceAsc'),
    ShopTag(title: "Price High to Low", tag: 'orderByPriceDesc'),
    ShopTag(title: "Stock", tag: 'orderByStock'),
    ShopTag(title: "Clear Sorting", tag: 'clear'),
  ];

  loadShop({required BuildContext context, int? pageIdx}) async {
    try {
      showWhereHouse = true;
      selectedTagIdx = 0;
      var userProvider = Provider.of<AuthProvider>(context, listen: false);

      var postBody = {
        "user_id": userProvider.userDetail.customerId,
        "default_storage_location": 1
      };
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      String url = pageIdx == null
          ? "$baseUrl/api/showWarehouse"
          : "$baseUrl/api/showWarehouse?page=${pageIdx}";
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
        },
        body: jsonEncode(postBody),
      );
      print(response.body);
      shopModel = ShopModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  resetAllFilters() {
    for (var attribute in shopModel.attributes!) {
      for (var filter in attribute.filterList) {
        filter.isSelected = false;
      }
    }
    selectedLocationIdx = 0;
    notifyListeners();
  }

  Future<bool> switchFavorite(
      {required int productId,
      required int productionYear,
      required BuildContext context,
      required String type}) async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);
    var postBody = {
      "user_id": userProvider.userDetail.customerId,
      "product_id": productId,
      "production_year": productionYear
    };
    try {
      String url = type == "remove"
          ? "$baseUrl/api/removeFavourite"
          : "$baseUrl/api/setFavourite";
      log(url);
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
        },
        body: jsonEncode(postBody),
      );
      log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json["status"] == 1) {
        return true;
      } else {
        _constant.getToast(title: "Something went wrong");
        return false;
      }
    } catch (e) {
      _constant.getToast(title: "Something went wrong");
      return false;
    }
  }

  switchLocation({required int index}) {
    selectedLocationIdx = index;
    notifyListeners();
  }

  switchSort({required int index}) {
    selectedSortIdx = index;
    notifyListeners();
  }

  addProductToCart(
      {required int quantity,
      required int productIdProdYear,
      required BuildContext context}) async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);

    Map<String, dynamic> postBody = {
      "product_id_prod_year": productIdProdYear,
      "quantity": quantity,
      "user_type": userProvider.userDetail.userType.name,
      "user_id": userProvider.userDetail.customerId
    };

    log(jsonEncode(postBody));
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/api/addtocart"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
        },
        body: jsonEncode(postBody),
      );
      await Provider.of<CartProvider>(context, listen: false)
          .getCartCount(context: context);
      _constant.getToast(title: jsonDecode(response.body)["message"]);
    } catch (e) {
      _constant.getToast(title: "Something went wrong");
    }
  }

  getFilterData({required BuildContext context, int? pageIdx}) async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);
    showWhereHouse = false;

    // filters
    Map<String, dynamic> filters = {};
    if(shopModel.attributes != null) {
      for (var attribute in shopModel.attributes!) {
        String key = "";
        List<num> value = [];
        int filterCount = 0;
        if (attribute.filterList.isNotEmpty) {
          key = attribute.title;
          for (var item in attribute.filterList) {
            if (item.isSelected) {
              value.add(
                  item.id == null ? num.parse(item.title) : num.parse(
                      item.id!));
              filterCount++;
            }
          }
          if (filterCount > 0) {
            filters[key] = value;
          }
        }
      }
    }
    // for tags
    Map<String, dynamic> tagMap = {};
    for (int i = 0; i < tagList.length; i++) {
      tagMap[tagList[i].tag] = selectedTagIdx == i ? true : false;
    }

    Map<String, dynamic> postBody = {
      "user_id": userProvider.userDetail.customerId,
      "default_storage_location": 1,
      ...filters,
      ...tagMap,
      "order_asc": selectedSortIdx == 0 ? true : false,
      "order_desc": selectedSortIdx == 1 ? true : false,
      "order_stock": selectedSortIdx == 2 ? true : false,
      if (searchController.text != "") "search": searchController.text
    };

    try {
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      String url = pageIdx == null
          ? "$baseUrl/api/getFilterData?page=1"
          : "$baseUrl/api/getFilterData?page=$pageIdx";

      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
        },
        body: jsonEncode(postBody),
      );

      print(response.body);

      shopModel = ShopModel.fromJson(jsonDecode(response.body));

      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  getOffer(
      {required BuildContext context,
      int? pageIdx,
      required List<String> offers}) async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);
    showWhereHouse = false;
    selectedTagIdx = 4;

    // for tags
    Map<String, dynamic> tagMap = {};
    for (int i = 0; i < tagList.length; i++) {
      tagMap[tagList[i].tag] = selectedTagIdx == i ? true : false;
    }

    Map<String, dynamic> postBody = {
      "user_id": userProvider.userDetail.customerId,
      "default_storage_location": 1,
      "Offer Brand": offers,
      ...tagMap,
      "order_asc": selectedSortIdx == 0 ? true : false,
      "order_desc": selectedSortIdx == 1 ? true : false,
      "order_stock": selectedSortIdx == 2 ? true : false,
      if (searchController.text != "") "search": searchController.text
    };

    print(postBody);
    try {
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      String url = pageIdx == null
          ? "$baseUrl/api/getFilterData?page=1"
          : "$baseUrl/api/getFilterData?page=$pageIdx";

      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
        },
        body: jsonEncode(postBody),
      );

      shopModel = ShopModel.fromJson(jsonDecode(response.body));


      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  getBestSellers(
      {required BuildContext context,
        int? pageIdx,
        }) async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);
    showWhereHouse = false;
    selectedTagIdx = 3;

    // for tags
    Map<String, dynamic> tagMap = {};
    for (int i = 0; i < tagList.length; i++) {
      tagMap[tagList[i].tag] = selectedTagIdx == i ? true : false;
    }

    Map<String, dynamic> postBody = {
      "user_id": userProvider.userDetail.customerId,
      "default_storage_location": 1,
      ...tagMap,
      "order_asc": selectedSortIdx == 0 ? true : false,
      "order_desc": selectedSortIdx == 1 ? true : false,
      "order_stock": selectedSortIdx == 2 ? true : false,
      if (searchController.text != "") "search": searchController.text
    };

    try {
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      String url = pageIdx == null
          ? "$baseUrl/api/getFilterData?page=1"
          : "$baseUrl/api/getFilterData?page=$pageIdx";

      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
        },
        body: jsonEncode(postBody),
      );

      print(response.body);

      shopModel = ShopModel.fromJson(jsonDecode(response.body));


      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
