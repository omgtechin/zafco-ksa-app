

import 'package:zafco_ksa/model/data_model/sales_order_model.dart';

class DashboardModel {
  DashboardModel({
    required this.dashboard,
  });
  late final Dashboard dashboard;

  DashboardModel.fromJson(Map<String, dynamic> json){
    dashboard = Dashboard.fromJson(json['dashboard']);
  }

}

class Dashboard {
  Dashboard({
    required this.recentOrders,
    required this.banners,
    required this.bestSellers,
    required this.customerData,
  });

  late final CustomerData? customerData;
  late final List<OrderData> recentOrders;
  late final List<String> banners;
  late final BestSellers bestSellers;

  Dashboard.fromJson(Map<String, dynamic> json){
    print("cp1");
    customerData = json['customer_data'] == null ? null: CustomerData.fromJson(json['customer_data']);
    print("cp2");
    recentOrders = List.from(json['recent_orders']).map((e)=>OrderData.fromJson(e)).toList();
    print("cp3");
    banners = List.from(json['banners']).map((e)=> e["banner_url"].toString()).toList();
    print("cp4");
    bestSellers = BestSellers.fromJson(json['best_sellers']);
    print("cp5");
  }
}


class CustomerData {
  CustomerData({
    required this.salesOrder,
    required this.tickets,
    required this.nextPaymentDueDate,
    required this.salesPerson,
    required this.salesPersonEmailId,
    required this.salesPersonPhoneNo,
    required this.invoices,
    required this.statementOfAccount,
    required this.currentOutstanding,
    required this.overdue,
  });
  late final int salesOrder;
  late final String tickets;
  late final String nextPaymentDueDate;
  late final String salesPerson;
  late final String salesPersonEmailId;
  late final String salesPersonPhoneNo;
  late final int invoices;
  late final String statementOfAccount;
  late final String currentOutstanding;
  late final String overdue;

  CustomerData.fromJson(Map<String, dynamic> json){
    salesOrder = json['sales_order'];
    tickets = json['Tickets'];
    nextPaymentDueDate = json['next_payment_due_date'];
    salesPerson = json['sales_person'];
    salesPersonEmailId = json['sales_person_email_id'];
    salesPersonPhoneNo = json['sales_person_phone_no'];
    invoices = json['invoices'];
    statementOfAccount = json['statement_of_account'];
    currentOutstanding = json['current_outstanding'];
    overdue = json['overdue'];
  }


}

class RecentOrder {
  RecentOrder({
    required this.id,
    required this.orderId,
    required this.orderCode,
    required this.userId,
    required this.customerId,
    required this.status,
    required this.currency,
    required this.amountTotal,
    required this.invoiceCustomerId,
    required this.shipCustomerId,
    required this.createdAt,
    required this.updatedAt,
    required this.amountWithoutTax,
    required this.taxAmount,
  });
  late final int id;
  late final int orderId;
  late final String orderCode;
  late final int userId;
  late final int customerId;
  late final String status;
  late final String currency;
  late final String amountTotal;
  late final int invoiceCustomerId;
  late final int shipCustomerId;
  late final String createdAt;
  late final String updatedAt;
  late final String amountWithoutTax;
  late final String taxAmount;

  RecentOrder.fromJson(Map<String, dynamic> json){
    id = json['id'];
    orderId = json['order_id'];
    orderCode = json['order_code'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    status = json['status'];
    currency = json['currency'];
    amountTotal = json['amount_total'];
    invoiceCustomerId = json['invoice_customer_id'];
    shipCustomerId = json['ship_customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amountWithoutTax = json['amount_without_tax'];
    taxAmount = json['tax_amount'];
  }

}

class BestSellers {
  BestSellers({
    required this.products,
  });
  late final List<Products> products;

  BestSellers.fromJson(Map<String, dynamic> json){
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
  }

}

class Products {
  Products({
    required this.id,
    required this.name,
    required this.sku,
    required this.stock,
    required this.year,
    required this.price,
    required this.image,
    required this.productIdProdYear,
    required this.promotions,
  });
  late final int id;
  late final String name;
  late final String sku;
  late final String stock;
  late final int year;
  late final String price;
  late final String image;
  late final int productIdProdYear;
  late final List<String> promotions;

  Products.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    stock = json['stock'];
    year = json['year'];
    price = json['price'];
    image = json['image'];
    productIdProdYear = json['product_id_prod_year'];
    promotions = List.castFrom(json['promotions']);
  }

}