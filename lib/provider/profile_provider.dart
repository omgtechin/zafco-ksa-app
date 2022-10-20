import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../model/data_model/personal_detail_model.dart';
import '../../model/data_model/user_offer_model.dart';
import '../../model/data_model/user_sales_person_model.dart';

import '../core/constant.dart';
import '../core/enum/connection_status.dart';
import '../model/data_model/catalogue_model.dart';
import 'auth_provider.dart';

class ProfileProvider with ChangeNotifier {
  late PersonalDetailModel personalDetailModel;
  late CatalogueModel catalogueModel;
  late UserOfferModel offerModel;
  late UserSalesPersonModel userSalesPersonModel;

  ConnectionStatus connectionStatus = ConnectionStatus.none;

  getPersonalDetail({required BuildContext context}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {"user_id": userProvider.userDetail.userId.toString()};
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/userPersonalDetails"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      print(response.body);
      personalDetailModel =
          PersonalDetailModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      print(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  getCatalogue({required BuildContext context}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/userCatalogue"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
      );
      print(response.body);
      catalogueModel = CatalogueModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      print(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  getUserOffer({required BuildContext context}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/userOfferPage"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
      );
      print(response.body);
      offerModel = UserOfferModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      print(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  getUserSalesPerson({required BuildContext context}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {"user_id": userProvider.userDetail.customerId.toString()};

      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/userSalesPerson"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      print(postBody);
      print("salesperson");
      print(response.body);
      userSalesPersonModel =
          UserSalesPersonModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      print(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }

  onContactFormSubmit({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String subject,
    required String question,
    required String company,
    required BuildContext context,
  }) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      Map<String, dynamic> postBody = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "subject": subject,
        "question": question,
        "company": company,
      };
      var response = await http.post(
        Uri.parse("$baseUrl/api/saveContactUs"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );

      Constant().getToast(title:jsonDecode(response.body)["message"]);
    } catch (e) {
      Constant().getToast(title: "Something went wrong");
    }
  }
}
