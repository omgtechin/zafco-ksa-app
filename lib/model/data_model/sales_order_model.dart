class SalesOrderModel {
  SalesOrderModel({
    required this.orders,
  });

  late final Orders orders;

  SalesOrderModel.fromJson(Map<String, dynamic> json) {
    print(json);
    orders = Orders.fromJson(json['orders']);
  }
}

class Orders {
  Orders({
    required this.currentPage,
    required this.orderData,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  late final int currentPage;
  late final List<OrderData> orderData;
  late final String firstPageUrl;
  late final int? from;
  late final int lastPage;
  late final String lastPageUrl;
  late final List<Links> links;
  late final String? nextPageUrl;
  late final String path;
  late final int perPage;
  late final String? prevPageUrl;
  late final int to;
  late final int total;

  Orders.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    orderData = List.from(json['data']).map((e) {

      return OrderData.fromJson(e);
    }).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];

    links = List.from(json['links']).map((e) => Links.fromJson(e)).toList();

    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];

  }
}

class OrderData {
  OrderData({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.orderCode,
    required this.status,
    required this.amountTotal,
    required this.createdAt,
    required this.user,
    required this.trackingUrl
  });

  late final int id;
  late final int userId;
  late final int? orderId;
  late final String orderCode;
  late final String status;
  late final String amountTotal;
  late final String createdAt;
  late final User user;
  late final String? trackingUrl;

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    trackingUrl = json['tracking_url'];
    orderCode = json['order_code'] ??"";
    status = json['status'];
    amountTotal = json['amount_total'];
    createdAt = json['created_at'];
    user = User.fromJson(json['user']);
  }
}

class User {
  User({
    required this.id,
    required this.name,
  });

  late final int id;
  late final String name;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Links {
  Links({
    this.url,
    required this.label,
    required this.active,
  });

  late final String? url;
  late final String label;
  late final bool active;

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}
