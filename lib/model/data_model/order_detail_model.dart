class OrderShippingModel {
  OrderShippingModel({
    required this.message,
    required this.shippings,
  });

  late final String message;
  late final List<Shippings> shippings;

  OrderShippingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    shippings = json['shippings'] == null ?[]:
        List.from(json['shippings']).map((e) => Shippings.fromJson(e)).toList();
  }
}

class Shippings {
  Shippings({
    required this.id,
    required this.orderId,
    required this.orderCode,
    required this.orderShipId,
    required this.name,
    required this.state,
    required this.shipDate,
    required this.trackingUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  late final int id;
  late final int orderId;
  late final String orderCode;
  late final int orderShipId;
  late final String name;
  late final String state;
  late final String shipDate;
  late final String trackingUrl;
  late final String createdAt;
  late final String updatedAt;

  Shippings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderCode = json['order_code'];
    orderShipId = json['order_ship_id'];
    name = json['name'];
    state = json['state'];
    shipDate = json['ship_date'];
    trackingUrl = json['tracking_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
