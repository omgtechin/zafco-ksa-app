class InvoiceModel {
  InvoiceModel({
    required this.invoices,
  });

  late final Invoices invoices;

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    invoices = Invoices.fromJson(json['invoices']);
  }
}

class Invoices {
  Invoices({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  late final int currentPage;
  late final List<InvoiceData> data;
  late final String firstPageUrl;
  late final int? from;
  late final int lastPage;
  late final String lastPageUrl;
  late final List<Links> links;
  late final String? nextPageUrl;
  late final String path;
  late final int? perPage;
  late final int? to;
  late final int total;

  Invoices.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e) => InvoiceData.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];

    lastPageUrl = json['last_page_url'];
    links = List.from(json['links']).map((e) => Links.fromJson(e)).toList();
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class InvoiceData {
  InvoiceData({
    required this.id,
    required this.customerId,
    required this.salesperson,
    required this.invoiceId,
    required this.invoiceCode,
    required this.invoiceDate,
    this.dueDate,
    required this.status,
    required this.currency,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  late final int id;
  late final String customerId;
  late final String salesperson;
  late final int invoiceId;
  late final String invoiceCode;
  late final String invoiceDate;
  late final String? dueDate;
  late final String status;
  late final String currency;
  late final String price;
  late final String createdAt;
  late final String updatedAt;

  InvoiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    salesperson = json['salesperson'];
    invoiceId = json['invoice_id'];
    invoiceCode = json['invoice_code'];
    invoiceDate = json['invoice_date'];
    dueDate = null;
    status = json['status'];
    currency = json['currency'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    url = null;
    label = json['label'];
    active = json['active'];
  }
}
