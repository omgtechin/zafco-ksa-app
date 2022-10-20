import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../core/enum/user_type.dart';
import '../../../../model/data_model/dashboard_model.dart';

import '../core/enum/connection_status.dart';
import 'auth_provider.dart';

class DashboardProvider with ChangeNotifier {
  ConnectionStatus connectionStatus = ConnectionStatus.none;
  late DashboardModel dashboardData;

  loadDashboard({required BuildContext context}) async {
    try {
      var userProvider = Provider.of<AuthProvider>(context, listen: false);
      var postBody = {
        "user_id": userProvider.userDetail.userType == UserType.employee
            ? null
            : userProvider.userDetail.customerId
      };
      connectionStatus = ConnectionStatus.active;
      notifyListeners();
      var response = await http.post(
        Uri.parse("$baseUrl/api/dashboard"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${userProvider.userDetail.accessToken}",
          "user_id": userProvider.userDetail.userId.toString()
        },
        body: jsonEncode(postBody),
      );
      dashboardData = DashboardModel.fromJson(jsonDecode(response.body));
      connectionStatus = ConnectionStatus.done;
    } catch (e) {
      log(e.toString());
      connectionStatus = ConnectionStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
