
class CartModel {
  CartModel({
    required this.cartItems,
    required this.orderSummary,
  });

  late final List<CartItem> cartItems;
  late final OrderSummary orderSummary;

  CartModel.fromJson(Map<String, dynamic> json) {
    cartItems = List.from(json['cart_items'])
        .map((e) => CartItem.fromJson(e))
        .toList();
    orderSummary =OrderSummary.fromJson(json['order_summary']);

  }
}

class CartItem {
  CartItem({
    required this.id,
    required this.userId,
    this.salespersonId,
    required this.customerId,
    required this.productId,
    required this.productIdProdYear,
    required this.quantity,
    required this.name,
    required this.price,
    required this.currency,
    required this.routeId,
    required this.productionYear,
    required this.lotId,
    required this.createdAt,
    required this.stock,
    required this.updatedAt,
    required this.promotionQuantity,
    required this.cloned,
    required this.totalPrice,
    required this.promotion,
    required this.product,
  });

  late final int id;
  late final int userId;
  late final int? salespersonId;
  late final int customerId;
  late final int productId;
  late final int productIdProdYear;
  late final int quantity;
  late final String name;
  late final String price;
  late final int stock;
  late final String currency;
  late final int routeId;
  late final int productionYear;
  late final int lotId;
  late final String createdAt;
  late final String updatedAt;
  late final String promotionQuantity;
  late final bool cloned;
  late final String promotion;
  late final String totalPrice;
  late final Product product;

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    salespersonId = json["salesperson_id"];
    customerId = json['customer_id'];
    productId = json['product_id'];
    productIdProdYear = json['product_id_prod_year'];
    quantity = json['quantity'];
    stock = json["stock"];
    name = json['name'];
    price = json['price'].toString();
    currency = json['currency'];
    routeId = json['route_id'];
    productionYear = json['production_year'];
    lotId = json['lot_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promotionQuantity = json['promotion_quantity'].toString();

    cloned = json['cloned'];

    promotion = json['promotion'].toString();
    totalPrice = json['total_price'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  Product({
    required this.id,
    required this.brandId,
    required this.productId,
    required this.productTmplId,
    required this.masterMaterial,
    required this.name,
    required this.materialType,
    required this.matCategoryId,
    this.tyrePatternId,
    required this.rimSize,
    required this.productSizeId,
    required this.image_256,
    this.tyreApplicationId,
    required this.segmentId,
    required this.createdAt,
    required this.updatedAt,
  });

  late final int id;
  late final int brandId;
  late final int productId;
  late final int productTmplId;
  late final String masterMaterial;
  late final String name;
  late final String materialType;
  late final int matCategoryId;
  late final int? tyrePatternId;
  late final String rimSize;
  late final int productSizeId;
  late final String image_256;
  late final int? tyreApplicationId;
  late final int segmentId;
  late final String createdAt;
  late final String updatedAt;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    productId = json['product_id'];
    productTmplId = json['product_tmpl_id'];
    masterMaterial = json['master_material'];
    name = json['name'];
    materialType = json['material_type'];
    matCategoryId = json['mat_category_id'];
    tyrePatternId = null;
    rimSize = json['rim_size'];
    productSizeId = json['product_size_id'];
    image_256 = json['image_256'];
    tyreApplicationId = null;
    segmentId = json['segment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class OrderSummary {
  OrderSummary({
    required this.orderQuantity,
    required this.productDetail,
  });
  late final OrderQuantity orderQuantity;
  late final List<ProductDetail> productDetail;

  OrderSummary.fromJson(Map<String, dynamic> json){
    orderQuantity = OrderQuantity.fromJson(json['order_quantity']);
    productDetail = List.from(json['products']).map((e)=>ProductDetail.fromJson(e)).toList();
  }
}

class OrderQuantity {
  OrderQuantity({
    required this.totalQuantity,
    required this.subTotal,
    required this.tax,
    required this.grandTotal,
  });
  late final int totalQuantity;
  late final num subTotal;
  late final num tax;
  late final num grandTotal;

  OrderQuantity.fromJson(Map<String, dynamic> json){
    totalQuantity = json['total_quantity'];
    subTotal = json['sub_total'];
    tax = json['tax'];
    grandTotal = json['grand_total'];
  }

}

class ProductDetail {
  ProductDetail({
    required this.productName,
    required this.productTotalPrice,
    required this.quantity,
  });
  late final String productName;
  late final int productTotalPrice;
  late final int quantity;

  ProductDetail.fromJson(Map<String, dynamic> json){
    productName = json['product_name'];
    productTotalPrice = json['product_total_price'];
    quantity = json['quantity'];
  }
}
