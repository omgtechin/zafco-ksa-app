class PersonalDetailModel {
  PersonalDetailModel({
    required this.userData,
  });

  late final UserData userData;

  PersonalDetailModel.fromJson(Map<String, dynamic> json) {
    userData = UserData.fromJson(json['user_data']);
  }
}

class UserData {
  UserData({
    required this.email,
    required this.phone,
    required this.billingAddress,
    required this.shippingAddresses,
  });

  late final String? email;
  late final String phone;
  late final String billingAddress;
  late final List<ShippingAddresses> shippingAddresses;

  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    billingAddress = json['billing_address'];
    shippingAddresses = List.from(json['shippingAddresses'])
        .map((e) => ShippingAddresses.fromJson(e))
        .toList();
  }
}

class ShippingAddresses {
  ShippingAddresses({
    required this.address,
  });

  late final String address;

  ShippingAddresses.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }
}
