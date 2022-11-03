import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constant.dart';
import '../../../../core/routes.dart';

import '../core/cache_client.dart';
import '../core/enum/connection_status.dart';
import '../model/data_model/uesr_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthProvider with ChangeNotifier {
  final Constant _constant = Constant();
  ConnectionStatus connectionStatus = ConnectionStatus.none;
  late UserDetailModel userDetail;

  login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    var postBody = {"email": email, "password": password};
    notifyListeners();
    try {
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      http.Response response =
          await http.post(Uri.parse("$baseUrl/api/login"), body: postBody);
      if (response.statusCode == 200) {
        userDetail = UserDetailModel.fromJson(jsonDecode(response.body));
        await cashAuthData(loginKey: password, loginId: email);
        Navigator.of(context)
            .pushReplacementNamed(Screen.mainScreen.toString());
      } else {
        _constant.getToast(title: response.body);
      }
    } catch (e) {
      connectionStatus = ConnectionStatus.error;

    } finally {
      connectionStatus = ConnectionStatus.none;
      notifyListeners();
    }
  }

  Future<String> activateAccount({required String email}) async {
    var postBody = {"email": email};
    try {
      http.Response response = await http
          .post(Uri.parse("$baseUrl/api/activateAccount"), body: postBody);
      if (response.statusCode == 200) {
        print("response : " + jsonDecode(response.body)["message"]);
        return jsonDecode(response.body)["message"];
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  Future<String> forgotPassword({required String email}) async {
    var postBody = {"email": email};
    try {
      http.Response response =
          await http.post(Uri.parse("$baseUrl/api/forgotPassword"), body: postBody);
      print(response.body);
      if (response.statusCode == 200) {
        print("response : " + jsonDecode(response.body)["message"]);
        return jsonDecode(response.body)["message"];
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  updateCustomer({required int updatedCustomerId}) {
    // customerId = -1 no customer selected
    userDetail = UserDetailModel(
        tokenType: userDetail.tokenType,
        expiresIn: userDetail.expiresIn,
        accessToken: userDetail.accessToken,
        refreshToken: userDetail.refreshToken,
        userType: userDetail.userType,
        customers: userDetail.customers,
        userId: userDetail.userId,
        customerId: updatedCustomerId);
    notifyListeners();
  }

  cashAuthData({required String loginKey, required String loginId}) async {
    CacheClient client = CacheClient();
    await client.putString(CashClientKey.loginId, loginId);
    await client.putString(CashClientKey.loginKey, loginKey);
  }

  Future<bool> get isUserLogedin async {
    CacheClient client = CacheClient();
    String? loginKey = await client.getString(CashClientKey.loginKey);
    String? loginId = await client.getString(CashClientKey.loginId);
    if (loginKey == null || loginId == null) {
      return false;
    }
    return true;
  }

  logOut({required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await Phoenix.rebirth(context);
    Navigator.of(context)
        .pushReplacementNamed(Screen.initialScreen.toString());
  }

  Future<bool> deactivateAccount({required BuildContext context}) async {
    http.Response response =
        await http.post(Uri.parse("$baseUrl/api/deactivateAccount"));

    if (response.statusCode == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      await Phoenix.rebirth(context);
      Navigator.of(context)
          .pushReplacementNamed(Screen.initialScreen.toString());
      return true;
    } else {
      Constant().getToast(title: AppLocalizations.of(context)!.wrongText);
      return false;
    }
  }
}
