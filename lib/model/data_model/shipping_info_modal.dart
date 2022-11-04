import 'cart_model.dart';

class ShippingDetailModel {
  ShippingDetailModel({
    required this.orderQuantity,
    required this.billingAddress,
    required this.shippingAddresses,
  });

  late final OrderQuantity orderQuantity;
  late final BillingAddress billingAddress;
  late final List<ShippingAddresses> shippingAddresses;

  ShippingDetailModel.fromJson(Map<String, dynamic> json) {
    orderQuantity = OrderQuantity.fromJson(json['order_quantity']);
    billingAddress = BillingAddress.fromJson(json['billing_address']);
    shippingAddresses = List.from(json['shippingAddresses'])
        .map((e) => ShippingAddresses.fromJson(e))
        .toList();
  }
}

class BillingAddress {
  BillingAddress({
    required this.address,
    required this.customerId,
  });

  late final String address;
  late final int customerId;

  BillingAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    customerId = json['customer_id'];
  }
}

class ShippingAddresses {
  ShippingAddresses({
    required this.customerId,
    required this.address,
  });

  late final String address;
  late final int? customerId;

  ShippingAddresses.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    customerId = json['customer_id'];
  }
}
