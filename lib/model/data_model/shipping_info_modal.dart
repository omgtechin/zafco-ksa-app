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
    required this.userType,
    required this.id,
    required this.status,
    required this.customerId,
    required this.name,
    required this.email,
    required this.phone,
    this.emailVerifiedAt,
    required this.address,
    required this.childIds,
    required this.pricelist,
    this.parentId,
    required this.type,
    required this.payerCustomerId,
    required this.propertyPaymentTermId,
    this.salespersonId,
    required this.customerSalesperson,
    this.image,
    required this.analyticAccountId,
    required this.propertyAccountPositionId,
    required this.accountManagerId,
    required this.empRespId,
    required this.customerBrands,
    required this.brandFilterFor,
    required this.createdAt,
    required this.updatedAt,
  });

  late final String userType;
  late final int id;
  late final int status;
  late final int customerId;
  late final String name;
  late final String? email;
  late final String phone;
  late final String? emailVerifiedAt;
  late final String address;
  late final List<dynamic> childIds;
  late final int pricelist;
  late final int? parentId;
  late final String type;
  late final int payerCustomerId;
  late final int propertyPaymentTermId;
  late final int? salespersonId;
  late final int customerSalesperson;
  late final String? image;
  late final int analyticAccountId;
  late final int propertyAccountPositionId;
  late final int accountManagerId;
  late final int empRespId;
  late final List<dynamic> customerBrands;
  late final String brandFilterFor;
  late final String createdAt;
  late final String updatedAt;

  ShippingAddresses.fromJson(Map<String, dynamic> json) {

    userType = json['user_type'];

    id = json['id'];
    status = json['status'];
    customerId = json['customer_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    address = json['address'];
    childIds = List.castFrom<dynamic, dynamic>(json['child_ids']);
    pricelist = json['pricelist'];
    parentId = json['parent_id'];
    type = json['type'];
    payerCustomerId = json['payer_customer_id'];
    propertyPaymentTermId = json['property_payment_term_id'];
    salespersonId = json['sales_peron_id'];
    customerSalesperson = json['customer_salesperson'];
    image = json['image'];
    analyticAccountId = json['analytic_account_id'];
    propertyAccountPositionId = json['property_account_position_id'];
    accountManagerId = json['account_manager_id'];
    empRespId = json['emp_resp_id'];
    customerBrands = List.castFrom<dynamic, dynamic>(json['customer_brands']);
    brandFilterFor = json['brand_filter_for'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
