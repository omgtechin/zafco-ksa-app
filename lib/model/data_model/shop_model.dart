import 'dart:developer';

class ShopModel {
  ShopModel({
    required this.products,
    required this.attributes,
    required this.location,
  });

  late final Products products;
  late final List<FilterModel>? attributes;
  late final List<FilterItem>? location;

  ShopModel.fromJson(Map<String, dynamic> json) {

    products = json['products'] == null
        ? Products(
            data: [],
            total: 0,
            to: null,
            nextPageUrl: null,
            lastPageUrl: null,
            lastPage: null,
            firstPageUrl: null,
            currentPage: null,
            from: null,
            prevPageUrl: null)
        : Products.fromJson(json['products']);
    print("cp2");
    attributes =json['attributes'] == null  ?null : getAttributes(json['attributes']);
    print("cp3");
    location =json['Select Location'] == null? null: List.from(json['Select Location'])
        .map((e) => FilterItem(id: e["id"].toString(), title: e["name"]))
        .toList();
    print("cp4");
  }

  List<FilterModel> getAttributes(Map<String, dynamic> json) {
    List<FilterModel> filterList = [];

    FilterModel rimSize = getAttributesFromList(
        title: "Select Rim Size", dataList: json["Select Rim Size"]);

    FilterModel size = getAttributesFromMap(
        title: "Select Size", dataList: json["Select Size"]);

    FilterModel category = getAttributesFromMap(
        title: "Select Category", dataList: json["Select Category"]);

    FilterModel pattern = getAttributesFromMap(
        title: "Select Pattern", dataList: json["Select Pattern"]);

    FilterModel brand = getAttributesFromMap(
        title: "Select Brand", dataList: json["Select Brand"]);

    FilterModel segment = getAttributesFromMap(
        title: "Select Segment", dataList: json["Select Segment"]);

    FilterModel year = getAttributesFromList(
        title: "Select Year", dataList: json["Select Year"]);

    filterList = [
      rimSize,
      size,
      category,
      pattern,
      brand,
      segment,
      year,
    ];
    return filterList;
  }

  FilterModel getAttributesFromList(
      {required title, required List<dynamic> dataList}) {
    FilterModel response = FilterModel(
        title: title,
        filterList: dataList
            .map((data) => FilterItem(id: null, title: data.toString()))
            .toList());
    return response;
  }

  FilterModel getAttributesFromMap(
      {required List<dynamic> dataList, required String title}) {
    List<FilterItem> filterList = [];
    for (var data in dataList) {
      Map<String, dynamic> map = data;
      int i = 0;
      String id = "";
      String title = "";
      map.forEach((key, value) {
        if (i == 0) {
          id = value.toString();
          i++;
        } else {
          title = value.toString();
        }
      });
      filterList.add(FilterItem(id: id, title: title));
    }

    return FilterModel(title: title, filterList: filterList);
  }
}

class Products {
  Products({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  late final int? currentPage;
  late final List<Data> data;
  late final String? firstPageUrl;
  late final int? from;
  late final int? lastPage;
  late final String? lastPageUrl;
  late final String? nextPageUrl;
  late final String? prevPageUrl;
  late final int? to;
  late final int total;

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    log("cp 1");
    data = json['data'] == null?[]: List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    log("cp 2");
    firstPageUrl = json['first_page_url'];
    log("cp 3");
    from = json['from'];
    log("cp 4");
    lastPage = json['last_page'];
    log("cp 5");
    lastPageUrl = json['last_page_url'];
    log("cp 6");
    log("cp 7");
    nextPageUrl = json['next_page_url'];
    log("cp 9");
    prevPageUrl = json['prev_page_url']?.toString();
    log("cp 11");
    to = json['to'];
    log("cp 12");
    total = json['total']??0;
    log("data loaded");
  }
}

class Data {
  Data({
    required this.id,
    required this.productIdProdYear,
    required this.userId,
    required this.customerId,
    required this.storageLocation,
    required this.productId,
    required this.userFavourites,
    this.image_256,
    required this.name,
    required this.masterMaterial,
    required this.productionYear,
    required this.lotId,
    required this.price,
    required this.currency,
    required this.rimSize,
    required this.brandId,
    required this.productSizeId,
    required this.matCategoryId,
    required this.promotions,
    required this.stock,
    this.productApplication,
    required this.product,
  });

  late final int id;
  late final int productIdProdYear;
  late final int userId;
  late final int customerId;
  late final int storageLocation;
  late final UserFavourites? userFavourites;
  late final int productId;
  late final String? image_256;
  late final String name;
  late final String masterMaterial;
  late final int productionYear;
  late final int lotId;
  late final String price;
  late final String currency;
  late final String rimSize;
  late final int brandId;
  late final int productSizeId;
  late final int matCategoryId;
  late final List<String> promotions;
  late final String stock;
  late final String? productApplication;
  late final Product product;

  Data.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    id = json['id'];
    productIdProdYear = json['product_id_prod_year'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    storageLocation = json['storage_location'];
    productId = json['product_id'];
    image_256 = json['image_256'];
    userFavourites = json['user_favourites'] == null
        ? null
        : UserFavourites.fromJson(json['user_favourites']);
    name = json['name'];
    masterMaterial = json['master_material'];
    productionYear = json['production_year'];
    lotId = json['lot_id'];
    price = json['price'];
    currency = json['currency'];
    rimSize = json['rim_size'];
    brandId = json['brand_id'];
    productSizeId = json['product_size_id'];
    matCategoryId = json['mat_category_id'];
    promotions = List.castFrom(json['promotions']);
    stock = json['stock'].toString();
    productApplication = json["product_application"]?.toString();

    product = Product.fromJson(json['product']);
  }
}

class Product {
  Product({
    required this.productId,
    required this.image,
  });

  late final int productId;
  late final String image;

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    image = json['image'];
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

class UserFavourites {
  UserFavourites({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productionYear,
    required this.createdAt,
    required this.updatedAt,
  });

  late final int id;
  late final int userId;
  late final int productId;
  late final int productionYear;
  late final String createdAt;
  late final String updatedAt;

  UserFavourites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    productionYear = json['production_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class FilterModel {
  String title;
  List<FilterItem> filterList;

  FilterModel({required this.title, required this.filterList});
}

class FilterItem {
  String? id;
  String title;
  bool isSelected;

  FilterItem({required this.id, required this.title, this.isSelected = false});
}
