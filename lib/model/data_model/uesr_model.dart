import '../../core/enum/user_type.dart';

class UserDetailModel {
  UserDetailModel(
      {required this.tokenType,
      required this.expiresIn,
      required this.accessToken,
      required this.refreshToken,
      required this.userType,
      required this.customers,
      required this.userId,
      required this.customerId});

  late final String tokenType;
  late final int expiresIn;
  late final String accessToken;
  late final String refreshToken;
  late final UserType userType;
  late final int userId;
  late final List<Customer> customers;
 late final int customerId;

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    userType =
        json['user_type'] == "customer" ? UserType.customer : UserType.employee;
    userId = json['user_id'];
    customers = json['customers']['customers'] == null ? []: List.from(json['customers']['customers'])
        .map((e) => Customer(id: e["id"], name: e["name"]))
        .toList();
    customerId = userType == UserType.customer ? userId : -1;
  }

}

class Customer {
  late final int id;
  late final String name;

  Customer({required this.id, required this.name});
}

