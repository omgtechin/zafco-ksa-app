class SalesOrderDetailModel {
  SalesOrderDetailModel({
    required this.message,
    required this.orderDetails,
  });

  late final String message;
  late final OrderDetails orderDetails;

  SalesOrderDetailModel.fromJson(Map<String, dynamic> json) {

    message = json['message'];
    orderDetails = OrderDetails.fromJson(json['order_details']);
  }
}

class OrderDetails {
  OrderDetails(
      {required this.id,
      required this.orderId,
      required this.orderCode,
      required this.userId,
      required this.customerId,
      required this.status,
      required this.currency,
      required this.amountTotal,
      required this.invoiceCustomerId,
      required this.createdAt,
      required this.updatedAt,
        required this.paymentTerms,
      required this.orderItems,
      required this.invoiceAddress,
      required this.shipAddress,
      required this.user,
      required this.taxAmount,
      required this.amountWithoutTax});

  late final int id;
  late final int orderId;
  late final String orderCode;
  late final int userId;
  late final int? customerId;
  late final String status;
  late final String currency;
  late final String amountTotal;
  late final int invoiceCustomerId;
  late final String? trackingUrl;
  late final String createdAt;
  late final String updatedAt;
  late final String paymentTerms;
  late final List<OrderItems> orderItems;
  late final String amountWithoutTax;
  late final String taxAmount;
  late final InvoiceAddress invoiceAddress;
  late final ShipAddress shipAddress;
  late final User user;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderCode = json['order_code'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    status = json['status'];

    currency = json['currency'];
    amountTotal = json['amount_total'];
    invoiceCustomerId = json['invoice_customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    trackingUrl = json['tracking_url'];
    paymentTerms = json['payment_term'];

    amountWithoutTax = json['amount_without_tax'];
    taxAmount = json['tax_amount'];

    orderItems = List.from(json['order_items'])
        .map((e) => OrderItems.fromJson(e))
        .toList();

    invoiceAddress = InvoiceAddress.fromJson(json['invoice_address']);
    shipAddress = ShipAddress.fromJson(json['ship_address']);
    print("cp1");
    user = User.fromJson(json['user']);
    print("cp8");
  }
}

class OrderItems {
  OrderItems({

    required this.orderId,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.name,
    required this.price,
    required this.currency,
    required this.routeId,
    required this.productionYear,
    required this.createdAt,
    required this.updatedAt,
    required this.totalAmount,
    required this.vat,
  });


  late final int orderId;
  late final int userId;
  late final int productId;
  late final int quantity;
  late final String name;
  late final String price;
  late final String currency;
  late final int? routeId;
  late final int productionYear;
  late final String createdAt;
  late final String updatedAt;
  late final int totalAmount;
  late final String vat;

  OrderItems.fromJson(Map<String, dynamic> json) {

    orderId = json['order_id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    name = json['name'];
    price = json['price'];
    currency = json['currency'];
    routeId = json['route_id'];
    productionYear = json['production_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalAmount = json['total_amount'];
    vat = json['vat'];
  }
}

class InvoiceAddress {
  InvoiceAddress({
    required this.customerId,
    required this.address,
  });

  late final int customerId;
  late final String address;

  InvoiceAddress.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    address = json['address'];
  }
}

class ShipAddress {
  ShipAddress({
    required this.customerId,
    required this.address,
  });

  late final int customerId;
  late final String address;

  ShipAddress.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    address = json['address'];
  }
}

class User {
  User({
    required this.userType,
    required this.id,
    required this.status,
    required this.customerId,
    required this.name,
    required this.phone,
    required this.address,
    required this.pricelist,
    required this.type,
    required this.payerCustomerId,
    required this.propertyPaymentTermId,
    required this.customerSalesperson,
    required this.salesPerson,
  });

  late final String userType;
  late final int id;
  late final int status;
  late final int customerId;
  late final String name;
  late final String phone;
  late final String address;
  late final int pricelist;
  late final String type;
  late final int payerCustomerId;
  late final int propertyPaymentTermId;
  late final int customerSalesperson;

  late final SalesPerson? salesPerson;

  User.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    id = json['id'];
    status = json['status'];
    customerId = json['customer_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];

    pricelist = json['pricelist'];
    type = json['type'];

    payerCustomerId = json['payer_customer_id'];
    propertyPaymentTermId = json['property_payment_term_id'];
    customerSalesperson = json['customer_salesperson'];

    salesPerson = json['sales_person'] == null
        ? null
        : SalesPerson.fromJson(json['sales_person']);
  }
}

class SalesPerson {
  SalesPerson({
    required this.userType,
    required this.id,
    required this.status,
    required this.customerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.salespersonId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  late final String userType;
  late final int id;
  late final int status;
  late final int customerId;
  late final String name;
  late final String email;
  late final String phone;
  late final int salespersonId;
  late final String image;
  late final String createdAt;
  late final String updatedAt;

  SalesPerson.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    id = json['id'];
    status = json['status'];
    customerId = json['customer_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    salespersonId = json['salesperson_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
