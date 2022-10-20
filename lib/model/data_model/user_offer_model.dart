class UserOfferModel {
  UserOfferModel({
    required this.offers,
  });

  late final List<Offers> offers;

  UserOfferModel.fromJson(Map<String, dynamic> json) {
    offers = List.from(json['offers']).map((e) => Offers.fromJson(e)).toList();
  }
}

class Offers {
  Offers({
    required this.id,
    required this.image,
    required this.start,
    required this.end,
    required this.brands,
    required this.createdAt,
    required this.updatedAt,
    required this.offerImage,
    required this.offerBrands,
  });

  late final int id;
  late final String image;
  late final String start;
  late final String end;
  late final String brands;
  late final String createdAt;
  late final String updatedAt;
  late final String offerImage;
  late final List<String> offerBrands;

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    start = json['start'];
    end = json['end'];
    brands = json['brands'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    offerImage = json['offer_image'];
    offerBrands = List.castFrom<dynamic, String>(json['offer_brands']);
  }
}
