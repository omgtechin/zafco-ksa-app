class OrderInvoiceModel {
  OrderInvoiceModel({
    required this.message,
    required this.invoices,
  });

  late final String message;
  late final List<Invoices> invoices;

  OrderInvoiceModel.fromJson(Map<String, dynamic> json) {
    print("json");
    print(json);
    message = json['message'];
    invoices = json['invoices'] == null ?[] :
        List.from(json['invoices']).map((e) => Invoices.fromJson(e)).toList();
  }
}

class Invoices {
  Invoices({
    required this.id,
    required this.invoiceName,
    required this.paymentState,
    required this.invoiceDate,
    required this.orderInvoiceId,
    required this.orderCode,
  });

  late final int id;
  late final String invoiceName;
  late final String paymentState;
  late final String invoiceDate;
  late final int orderInvoiceId;
  late final String orderCode;

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceName = json['invoice_name'];
    paymentState = json['payment_state'];
    invoiceDate = json['invoice_date'];
    orderInvoiceId = json['order_invoice_id'];
    orderCode = json['order_code'];
  }
}
