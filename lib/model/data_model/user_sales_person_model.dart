class UserSalesPersonModel {
  UserSalesPersonModel({
    required this.salesPerson,
  });

  late final SalesPerson salesPerson;

  UserSalesPersonModel.fromJson(Map<String, dynamic> json) {
    salesPerson = SalesPerson.fromJson(json['sales_person']);
  }
}

class SalesPerson {
  SalesPerson({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  late final String name;
  late final String email;
  late final String phone;
  late final String image;

  SalesPerson.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }
}
